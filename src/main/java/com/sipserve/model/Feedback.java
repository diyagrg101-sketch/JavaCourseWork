package com.sipserve.model;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Feedback {

    private static final DateTimeFormatter DATE_FMT =
            DateTimeFormatter.ofPattern("MMM d, yyyy", Locale.ENGLISH);

    private int       id;
    private int       userId;       // FK → users.id
    private int       productId;    // FK → products.id
    private String    userName;     // joined from users for display only
    private String    productName;  // joined from products for display only
    private int       rating;       // 1–5
    private String    review;       // TEXT column
    private Timestamp createdAt;

    public Feedback() {}

    /** Constructor used by FeedbackServlet when inserting */
    public Feedback(int userId, int productId, int rating, String review) {
        this.userId    = userId;
        this.productId = productId;
        this.rating    = rating;
        this.review    = review;
    }

    // ── Display helpers ───────────────────────────────────────────────────────

    /** "May 19, 2026" — community feed */
    public String getFormattedDate() {
        if (createdAt == null) return "";
        return createdAt.toLocalDateTime().format(DATE_FMT);
    }

    /** "2h ago" — admin report */
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

    public int    getId()                         { return id; }
    public void   setId(int id)                   { this.id = id; }

    public int    getUserId()                     { return userId; }
    public void   setUserId(int userId)           { this.userId = userId; }

    public int    getProductId()                  { return productId; }
    public void   setProductId(int productId)     { this.productId = productId; }

    public String getUserName()                   { return userName; }
    public void   setUserName(String userName)    { this.userName = userName; }

    public String getProductName()                { return productName; }
    public void   setProductName(String n)        { this.productName = n; }

    public int    getRating()                     { return rating; }
    public void   setRating(int rating)           { this.rating = rating; }

    public String getReview()                     { return review; }
    public void   setReview(String review)        { this.review = review; }

    /** Alias so JSPs using fb.message still work */
    public String getMessage()                    { return review; }

    public Timestamp getCreatedAt()               { return createdAt; }
    public void      setCreatedAt(Timestamp t)    { this.createdAt = t; }
}
