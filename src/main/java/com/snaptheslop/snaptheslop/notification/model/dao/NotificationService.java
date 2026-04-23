package com.snaptheslop.snaptheslop.notification.model.dao;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.notification.model.NotificationItem;

public class NotificationService {

    private final NotificationDAO dao = new NotificationDAO();

    public void triggerNewIssueReported(Issue issue) {
        NotificationItem n = new NotificationItem();
        n.setAudience("MUNICIPALITY");
        n.setMunicipalityId(issue.getMunicipalityId());
        n.setIssueId(issue.getId());
        n.setType("NEW_ISSUE");
        n.setTitle("New Issue Reported: #" + issue.getIssueId());
        n.setMessage("A new " + issue.getCategory() + " issue has been reported in Ward " + issue.getWardNo() + ".");
        n.setEventKey("ISSUE_NEW_" + issue.getId());
        dao.createIfAbsent(n);
    }

    public void triggerStatusChanged(Issue issue, String oldStatus, String newStatus) {
        if (oldStatus.equals(newStatus)) return;

        // Citizen Notification: Status or Acknowledgement
        NotificationItem cn = new NotificationItem();
        cn.setAudience("CITIZEN");
        cn.setUserId(issue.getUserId());
        cn.setIssueId(issue.getId());
        cn.setType("STATUS_CHANGE");

        if ("Open".equals(oldStatus)) {
            cn.setTitle("Your issue #" + issue.getIssueId() + " was acknowledged");
            cn.setMessage("Your report is now " + newStatus + ".");
            cn.setEventKey("ISSUE_ACK_" + issue.getId());
        } else {
            cn.setTitle("Issue #" + issue.getIssueId() + " status updated");
            cn.setMessage("Status changed from " + oldStatus + " to " + newStatus + ".");
            cn.setEventKey("ISSUE_STATUS_" + issue.getId() + "_" + newStatus.replace(" ", ""));
        }
        dao.createIfAbsent(cn);
    }

    public void triggerPriorityChanged(Issue issue, String oldPriority, String newPriority) {
        if (oldPriority.equals(newPriority)) return;

        NotificationItem cn = new NotificationItem();
        cn.setAudience("CITIZEN");
        cn.setUserId(issue.getUserId());
        cn.setIssueId(issue.getId());
        cn.setType("PRIORITY_CHANGE");
        cn.setTitle("Issue #" + issue.getIssueId() + " priority updated");
        cn.setMessage("The priority of your report changed from " + oldPriority + " to " + newPriority + ".");
        cn.setEventKey("ISSUE_PRI_" + issue.getId() + "_" + newPriority);
        dao.createIfAbsent(cn);
    }

    public void triggerNewComment(Issue issue, int commenterId, String commenterRole) {
        // Notify the OTHER party
        if ("CITIZEN".equalsIgnoreCase(commenterRole) || commenterRole == null) {
            // Citizen commented -> notify municipality
            NotificationItem mn = new NotificationItem();
            mn.setAudience("MUNICIPALITY");
            mn.setMunicipalityId(issue.getMunicipalityId());
            mn.setIssueId(issue.getId());
            mn.setType("NEW_COMMENT");
            mn.setTitle("New Comment on #" + issue.getIssueId());
            mn.setMessage("A citizen posted a new comment on this issue.");
            mn.setEventKey("COMMENT_MUNI_" + issue.getId() + "_" + System.currentTimeMillis());
            dao.create(mn); // Allow duplicate comments
        } else {
            // Municipality/Admin commented (or other) -> notify citizen
            // Avoid notifying self if the author somehow comments on their own issue as non-citizen
            if (issue.getUserId() != commenterId) {
                NotificationItem cn = new NotificationItem();
                cn.setAudience("CITIZEN");
                cn.setUserId(issue.getUserId());
                cn.setIssueId(issue.getId());
                cn.setType("NEW_COMMENT");
                cn.setTitle("New comment on your issue #" + issue.getIssueId());
                cn.setMessage("The municipality or admin responded to your report.");
                cn.setEventKey("COMMENT_CIT_" + issue.getId() + "_" + System.currentTimeMillis());
                dao.create(cn);
            }
        }
    }

    public void triggerUpvoteMilestone(Issue issue, int currentVoteCount, int threshold) {
        // Notification for Citizen
        NotificationItem cn = new NotificationItem();
        cn.setAudience("CITIZEN");
        cn.setUserId(issue.getUserId());
        cn.setIssueId(issue.getId());
        cn.setType("UPVOTE_MILESTONE");
        cn.setTitle("Community interest in your report");
        cn.setMessage("Your issue #" + issue.getIssueId() + " reached " + threshold + " upvotes!");
        cn.setEventKey("UPVOTE_CIT_" + issue.getId() + "_T" + threshold);
        dao.createIfAbsent(cn);

        // Notification for Municipality
        NotificationItem mn = new NotificationItem();
        mn.setAudience("MUNICIPALITY");
        mn.setMunicipalityId(issue.getMunicipalityId());
        mn.setIssueId(issue.getId());
        mn.setType("UPVOTE_MILESTONE");
        mn.setTitle("High engagement on #" + issue.getIssueId());
        mn.setMessage("Issue in Ward " + issue.getWardNo() + " surpassed " + threshold + " community upvotes.");
        mn.setEventKey("UPVOTE_MUNI_" + issue.getId() + "_T" + threshold);
        dao.createIfAbsent(mn);
    }
    
    public void triggerSlaAlert(Issue issue, int hoursOpen) {
        NotificationItem mn = new NotificationItem();
        mn.setAudience("MUNICIPALITY");
        mn.setMunicipalityId(issue.getMunicipalityId());
        mn.setIssueId(issue.getId());
        mn.setType("SLA_ALERT");
        mn.setTitle("SLA Alert: #" + issue.getIssueId() + " open too long");
        mn.setMessage("Issue has been unresolved for over " + hoursOpen + " hours.");
        mn.setEventKey("SLA_" + issue.getId() + "_H" + hoursOpen);
        dao.createIfAbsent(mn);
    }
}
