<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Sip and Serve - Crafting the perfect cup and serving warm memories. Premium coffee and freshly baked delights in Pokhara." />
    <title>Sip and Serve | Bakery & Cafe</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/style.css" />
</head>
<body>

    <!-- =================== NAVBAR =================== -->
    <header class="navbar" id="navbar">
        <div class="container nav-container">
            <a href="#home" class="brand">
                <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
                <span class="brand-name">Sip and Serve</span>
            </a>

            <button class="nav-toggle" id="navToggle" aria-label="Toggle menu">
                <i class="fa-solid fa-bars"></i>
            </button>

            <nav class="nav-links" id="navLinks">
                <a href="#home" class="nav-link active">Home</a>
                <a href="${ctx}/manageProducts">Menu</a>
                <a href="#about" class="nav-link">About Us</a>
                <a href="#contact" class="nav-link">Contact Us</a>

                <div class="nav-actions">
                    <a href="${ctx}/login" class="btn-link">Login</a>
                    <a href="${ctx}/login" class="btn btn-primary">Sign In</a>
                </div>
            </nav>
        </div>
    </header>

    <!-- =================== HERO =================== -->
    <section class="hero" id="home">
        <div class="hero-overlay"></div>
        <div class="container hero-content">
            <span class="hero-badge">Now Open</span>
            <h1 class="hero-title">
                Sip into Serenity<br />
                Serve with Love.
            </h1>
            <p class="hero-subtitle">
                Experience with the perfect blend of coffee and freshly baked
                delights in the heart of city. Your daily ritual, elevated.
            </p>
            <div class="hero-actions">
                <a href="#menu" class="btn btn-primary btn-lg">Explore Menu</a>
                <a href="${ctx}/login" class="btn btn-outline btn-lg">Sign In</a>
            </div>
        </div>
    </section>

    <!-- =================== FEATURES =================== -->
    <section class="features">
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-wheat-awn"></i></div>
                    <h3 class="feature-title">Premium Beans</h3>
                    <p class="feature-text">Ethically sourced 100% beans roasted locally for peak flavor.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-bread-slice"></i></div>
                    <h3 class="feature-title">Baked Daily</h3>
                    <p class="feature-text">Our bakers start at dawn to ensure every bite is fresh & flaky.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <h3 class="feature-title">Quality First</h3>
                    <p class="feature-text">Strict hygiene and standard brewing protocols in every cup.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon"><i class="fa-regular fa-clock"></i></div>
                    <h3 class="feature-title">Quick Service</h3>
                    <p class="feature-text">Ordering made easy with our smart digital cafe management.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- =================== SIGNATURE DELIGHTS (DB-DRIVEN) =================== -->
    <section class="signature" id="menu">
        <div class="container">
            <div class="section-heading">
                <h2 class="section-title">Sip and Serve Signature Delight</h2>
                <p class="section-subtitle">
                    Our most loved specialties, handcrafted by our barista and pastry chefs.
                    Try them today and discover why they are local favorite.
                </p>
            </div>

            <c:if test="${not empty dbError}">
                <p class="db-error">${dbError}</p>
            </c:if>

            <c:choose>
                <c:when test="${empty signatureProducts}">
                    <p class="empty-state">No signature items available right now.</p>
                </c:when>
                <c:otherwise>
                    <div class="products-grid">
                        <c:forEach var="p" items="${signatureProducts}">
                            <article class="product-card">
                                <div class="product-img">
                                    <img src="${ctx}/image?id=${p.id}"
                                         alt="<c:out value='${p.name}'/>" />
                                </div>
                                <div class="product-body">
                                    <div class="product-head">
                                        <h3 class="product-name"><c:out value="${p.name}"/></h3>
                                        <span class="product-rating">
                                            <i class="fa-solid fa-star"></i>
                                            <fmt:formatNumber value="${p.rating}" minFractionDigits="1" maxFractionDigits="1"/>
                                        </span>
                                    </div>
                                    <p class="product-desc"><c:out value="${p.description}"/></p>
                                    <div class="product-foot">
                                        <span class="product-price">
                                            NRs <fmt:formatNumber value="${p.price}" maxFractionDigits="0"/>
                                        </span>
                                        <a href="${ctx}/product?id=${p.id}" class="btn btn-primary btn-sm">View Details</a>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- =================== ABOUT =================== -->
    <section class="about" id="about">
        <div class="container about-grid">
            <div class="about-img">
                <img src="${ctx}/assets/images/coffee-making.jpg" alt="Barista pouring latte art" />
            </div>
            <div class="about-content">
                <h2 class="section-title">Experience Coffee<br />Beyond the Ordinary</h2>
                <p class="about-text">
                    At Sip and Serve, we believe coffee is more than just a drink&mdash;it's an experience.
                    We meticulously select beans from the high-altitude hills of Nepal and masterfully
                    roast them to reveal complex notes of chocolate, caramel, and citrus.
                </p>
                <div class="about-features">
                    <div class="about-feature">
                        <i class="fa-solid fa-heart"></i>
                        <div>
                            <h4>Local Love</h4>
                            <p>Supporting local farmers.</p>
                        </div>
                    </div>
                    <div class="about-feature">
                        <i class="fa-solid fa-leaf"></i>
                        <div>
                            <h4>Always Fresh</h4>
                            <p>Brewed on demand.</p>
                        </div>
                    </div>
                </div>
                <a href="#" class="btn btn-primary">Read our Story</a>
            </div>
        </div>
    </section>

    <!-- =================== INFO BAR =================== -->
    <section class="info-bar">
        <div class="container info-grid">
            <div class="info-item">
                <i class="fa-solid fa-location-dot"></i>
                <h4>Visit Us</h4>
                <p>Newroad, Pokhara</p>
            </div>
            <div class="info-item">
                <i class="fa-regular fa-clock"></i>
                <h4>Opening Hours</h4>
                <p>Mon-Sun 07:00 Am - 10:00 Pm</p>
            </div>
            <div class="info-item">
                <i class="fa-regular fa-star"></i>
                <h4>Rated 4.9/5</h4>
                <p>By over 5000 coffee enthusiastic</p>
            </div>
        </div>
    </section>

    <!-- =================== FOOTER =================== -->
    <footer class="footer" id="contact">
        <div class="container footer-grid">
            <div class="footer-col">
                <a href="#home" class="brand">
                    <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
                    <span class="brand-name">Sip and Serve</span>
                </a>
                <p class="footer-text">
                    Crafting the perfect cup and serving warm memories since 2030.
                    Experience the finest cafe culture in town.
                </p>
                <p class="footer-copy">2026 Sahaja Bistro. All rights reserved.</p>
            </div>

            <div class="footer-col">
                <h4 class="footer-title">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="#home">Home</a></li>
                    <li><a href="#menu">Menu</a></li>
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#contact">Contact Us</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4 class="footer-title">Contact Us</h4>
                <ul class="footer-links">
                    <li><i class="fa-solid fa-phone"></i> +977 9841 123 4567</li>
                    <li><i class="fa-solid fa-envelope"></i> sipandserve@gmail.com</li>
                </ul>
            </div>

            <div class="footer-col">
                <h4 class="footer-title">Follow Us</h4>
                <div class="social-links">
                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" aria-label="TikTok"><i class="fa-brands fa-tiktok"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <script src="${ctx}/assets/js/main.js"></script>
</body>
</html>
