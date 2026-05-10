/* ===========================================================
   Sip and Serve — Main JS
   Handles: mobile nav, navbar shadow on scroll, smooth scroll,
            active link highlighting on scroll
   =========================================================== */

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', init);

    function init() {
        setupMobileNav();
        setupNavbarScroll();
        setupActiveLinkHighlight();
        setupSmoothScrollClose();
    }

    /* -------- Mobile nav toggle -------- */
    function setupMobileNav() {
        var toggle = document.getElementById('navToggle');
        var links = document.getElementById('navLinks');
        if (!toggle || !links) return;

        toggle.addEventListener('click', function () {
            links.classList.toggle('open');
            var icon = toggle.querySelector('i');
            if (!icon) return;
            if (links.classList.contains('open')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-xmark');
            } else {
                icon.classList.remove('fa-xmark');
                icon.classList.add('fa-bars');
            }
        });

        // Close menu when clicking outside
        document.addEventListener('click', function (e) {
            if (!links.classList.contains('open')) return;
            if (links.contains(e.target) || toggle.contains(e.target)) return;
            links.classList.remove('open');
            var icon = toggle.querySelector('i');
            if (icon) {
                icon.classList.remove('fa-xmark');
                icon.classList.add('fa-bars');
            }
        });
    }

    /* -------- Close mobile menu after clicking a link -------- */
    function setupSmoothScrollClose() {
        var links = document.getElementById('navLinks');
        if (!links) return;

        var anchors = links.querySelectorAll('a[href^="#"]');
        anchors.forEach(function (a) {
            a.addEventListener('click', function () {
                if (links.classList.contains('open')) {
                    links.classList.remove('open');
                    var toggle = document.getElementById('navToggle');
                    var icon = toggle ? toggle.querySelector('i') : null;
                    if (icon) {
                        icon.classList.remove('fa-xmark');
                        icon.classList.add('fa-bars');
                    }
                }
            });
        });
    }

    /* -------- Navbar shadow on scroll -------- */
    function setupNavbarScroll() {
        var navbar = document.getElementById('navbar');
        if (!navbar) return;

        var ticking = false;
        window.addEventListener('scroll', function () {
            if (ticking) return;
            window.requestAnimationFrame(function () {
                if (window.scrollY > 8) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
                ticking = false;
            });
            ticking = true;
        });
    }

    /* -------- Highlight active section in navbar -------- */
    function setupActiveLinkHighlight() {
        var sections = document.querySelectorAll('section[id]');
        var navLinks = document.querySelectorAll('.nav-link');
        if (!sections.length || !navLinks.length) return;

        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (!entry.isIntersecting) return;
                var id = entry.target.getAttribute('id');
                navLinks.forEach(function (link) {
                    link.classList.toggle(
                        'active',
                        link.getAttribute('href') === '#' + id
                    );
                });
            });
        }, { rootMargin: '-45% 0px -50% 0px', threshold: 0 });

        sections.forEach(function (sec) { observer.observe(sec); });
    }
})();

