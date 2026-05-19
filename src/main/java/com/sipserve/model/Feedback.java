package com.sipserve.model;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Feedback {

    // ── Thread-safe, immutable formatters (replaces SimpleDateFormat) ─────────
    private static final DateTimeFormatter DATE_FMT =
            DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);

    private int       id;
    private String    userName;
    private String    userEmail;
    private int       rating;
    private String    message;
    private Timestamp createdAt;

    public Feedback() {}

    public Feedback(String userName, String userEmail, int rating, String message) {
        this.userName  = userName;
        this.userEmail = userEmail;
        this.rating    = rating;
        this.message   = message;
    }

    // ── Formatted dates ───────────────────────────────────────────────────────

    /** e.g. "May 19, 2026" — used in JSP community feed */
    public String getFormattedDate() {
        if (createdAt == null) return "";
        return createdAt.toLocalDateTime().format(DATE_FMT);
    }

    /** e.g. "2h ago / 1d ago" — relative label for admin report */
    public String getRelativeTime() {
        if (createdAt == null) return "";
        long diff  = System.currentTimeMillis() - createdAt.getTime();
        long mins  = diff / 60_000;
        long hours = mins  / 60;
        long days  = hours / 24;
        if (mins  < 60) return mins  + "m ago";
        if (hours < 24) return hours + "h ago";
        return days + "d ago";
    }

    // ── Getters / Setters ─────────────────────────────────────────────────────

    public int       getId()                           { return id; }
    public void      setId(int id)                     { this.id = id; }

    public String    getUserName()                     { return userName; }
    public void      setUserName(String userName)      { this.userName = userName; }

    public String    getUserEmail()                    { return userEmail; }
    public void      setUserEmail(String userEmail)    { this.userEmail = userEmail; }

    public int       getRating()                       { return rating; }
    public void      setRating(int rating)             { this.rating = rating; }

    public String    getMessage()                      { return message; }
    public void      setMessage(String message)        { this.message = message; }

    public Timestamp getCreatedAt()                    { return createdAt; }
    public void      setCreatedAt(Timestamp t)         { this.createdAt = t; }
}