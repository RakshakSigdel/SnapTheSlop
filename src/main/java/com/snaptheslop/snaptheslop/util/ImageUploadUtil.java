package com.snaptheslop.snaptheslop.util;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility for handling image file uploads in multipart form submissions.
 * Sprint 5: Validate file type/size and store image path safely.
 */
public class ImageUploadUtil {

    private static final Logger LOGGER = Logger.getLogger(ImageUploadUtil.class.getName());

    /** Allowed MIME types for uploaded images. */
    private static final Set<String> ALLOWED_TYPES = new HashSet<>(Arrays.asList(
            "image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"
    ));

    /** Max file size: 5 MB */
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024L;

    /** Sub-directory under the webapp root where issue images are stored. */
    public static final String UPLOAD_DIR = "uploads" + File.separator + "issues";

    // ── Public API ─────────────────────────────────────────────────────────

    /**
     * Validates and saves an uploaded image part to disk.
     *
     * @param part        The uploaded file Part from the multipart request.
     * @param uploadRoot  Absolute filesystem path to the upload folder
     *                    (obtain via getServletContext().getRealPath("/" + UPLOAD_DIR)).
     * @return            Web-relative path e.g. "/uploads/issues/abc.jpg",
     *                    or null if no file was submitted.
     * @throws IOException              if the file cannot be written.
     * @throws IllegalArgumentException if the file fails validation.
     */
    public static String saveImage(Part part, String uploadRoot) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        // 1. Validate content type
        String contentType = part.getContentType();
        if (contentType == null || !ALLOWED_TYPES.contains(contentType.toLowerCase())) {
            throw new IllegalArgumentException(
                    "Invalid file type: " + contentType + ". Only JPEG, PNG, GIF, and WebP are allowed.");
        }

        // 2. Validate file size
        if (part.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException(
                    "File too large (" + (part.getSize() / 1024) + " KB). Maximum allowed is 5 MB.");
        }

        // 3. Derive safe extension from MIME type (ignore client-supplied filename)
        String extension = mimeToExtension(contentType);

        // 4. Generate unique filename
        String filename = UUID.randomUUID().toString().replace("-", "") + extension;

        // 5. Ensure upload directory exists
        File dir = new File(uploadRoot);
        if (!dir.exists() && !dir.mkdirs()) {
            throw new IOException("Failed to create upload directory: " + uploadRoot);
        }

        // 6. Write file to disk
        String filePath = uploadRoot + File.separator + filename;
        try (InputStream in = part.getInputStream()) {
            Files.copy(in, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }

        LOGGER.log(Level.INFO, "Image saved: " + filePath);

        // Web-relative URL path (forward slashes for HTML src attribute)
        return "/uploads/issues/" + filename;
    }

    /** Returns true when the Part contains a non-empty file. */
    public static boolean hasFile(Part part) {
        return part != null && part.getSize() > 0;
    }

    // ── Private helpers ────────────────────────────────────────────────────

    private static String mimeToExtension(String mimeType) {
        if (mimeType == null) return ".jpg";
        switch (mimeType.toLowerCase()) {
            case "image/png":  return ".png";
            case "image/gif":  return ".gif";
            case "image/webp": return ".webp";
            default:           return ".jpg";
        }
    }
}
