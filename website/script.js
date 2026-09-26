/**
 * PulseCare Health Services - Interactive JavaScript Module
 */

document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initFAQ();
    initDoctorFilter();
    initVitalsSimulation();
    initMobileMenu();
    setTomorrowDateInModal();
});

/* -------------------------------------------------------------------------- */
/* Theme Toggle (Dark / Light Mode)                                           */
/* -------------------------------------------------------------------------- */
function initTheme() {
    const themeToggle = document.getElementById('themeToggle');
    const storedTheme = localStorage.getItem('pulsecare_theme') || 'light';
    
    if (storedTheme === 'dark') {
        document.body.setAttribute('data-theme', 'dark');
        themeToggle.innerHTML = '<i class="fa-solid fa-sun"></i>';
    } else {
        document.body.removeAttribute('data-theme');
        themeToggle.innerHTML = '<i class="fa-solid fa-moon"></i>';
    }

    themeToggle.addEventListener('click', () => {
        const isDark = document.body.hasAttribute('data-theme');
        if (isDark) {
            document.body.removeAttribute('data-theme');
            localStorage.setItem('pulsecare_theme', 'light');
            themeToggle.innerHTML = '<i class="fa-solid fa-moon"></i>';
        } else {
            document.body.setAttribute('data-theme', 'dark');
            localStorage.setItem('pulsecare_theme', 'dark');
            themeToggle.innerHTML = '<i class="fa-solid fa-sun"></i>';
        }
    });
}

/* -------------------------------------------------------------------------- */
/* Mobile Menu Toggle                                                         */
/* -------------------------------------------------------------------------- */
function initMobileMenu() {
    const btn = document.getElementById('mobileMenuBtn');
    const navLinks = document.getElementById('navLinks');
    if (!btn || !navLinks) return;

    btn.addEventListener('click', () => {
        const isVisible = navLinks.style.display === 'flex';
        navLinks.style.display = isVisible ? 'none' : 'flex';
        navLinks.style.flexDirection = 'column';
        navLinks.style.position = 'absolute';
        navLinks.style.top = '80px';
        navLinks.style.left = '0';
        navLinks.style.width = '100%';
        navLinks.style.background = 'var(--bg-card)';
        navLinks.style.padding = '1.5rem';
        navLinks.style.boxShadow = 'var(--shadow-lg)';
    });
}

/* -------------------------------------------------------------------------- */
/* FAQ Accordion Toggle                                                       */
/* -------------------------------------------------------------------------- */
function initFAQ() {
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        const trigger = item.querySelector('.faq-trigger');
        trigger.addEventListener('click', () => {
            const isActive = item.classList.contains('active');
            
            // Close all
            faqItems.forEach(i => i.classList.remove('active'));

            // Toggle current
            if (!isActive) {
                item.classList.add('active');
            }
        });
    });
}

/* -------------------------------------------------------------------------- */
/* Doctor Category Filter                                                     */
/* -------------------------------------------------------------------------- */
function initDoctorFilter() {
    const tabs = document.querySelectorAll('.tab-btn');
    const cards = document.querySelectorAll('.doctor-card');

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const filter = tab.getAttribute('data-filter');

            cards.forEach(card => {
                const category = card.getAttribute('data-category');
                if (filter === 'all' || category === filter) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
}

/* -------------------------------------------------------------------------- */
/* Vitals Real-Time Simulation                                                */
/* -------------------------------------------------------------------------- */
function initVitalsSimulation() {
    const bpmEl = document.getElementById('liveBpm');
    const bpEl = document.getElementById('liveBp');
    const spo2El = document.getElementById('liveSpo2');

    if (!bpmEl || !bpEl || !spo2El) return;

    setInterval(() => {
        // Fluctuate Heart Rate 68 - 76
        const newBpm = Math.floor(Math.random() * (76 - 68 + 1)) + 68;
        bpmEl.textContent = newBpm;

        // Slight BP variation
        const sys = Math.floor(Math.random() * (122 - 116 + 1)) + 116;
        const dia = Math.floor(Math.random() * (80 - 76 + 1)) + 76;
        bpEl.textContent = `${sys}/${dia}`;

        // SpO2 98-100%
        const spo2 = Math.floor(Math.random() * (100 - 98 + 1)) + 98;
        spo2El.textContent = spo2;
    }, 4000);
}

function simulateVitalsAlert() {
    const bpmEl = document.getElementById('liveBpm');
    if (bpmEl) {
        bpmEl.textContent = '72';
    }
    alert('✅ Vitals sync refreshed! Heart Rate: 72 BPM | BP: 118/78 mmHg | SpO2: 99%. All metrics normal.');
}

/* -------------------------------------------------------------------------- */
/* Booking Modal & Step Handler                                               */
/* -------------------------------------------------------------------------- */
function openBookingModal(serviceName = null, doctorName = null) {
    const modal = document.getElementById('bookingModal');
    const serviceSelect = document.getElementById('modalService');
    const doctorSelect = document.getElementById('modalDoctor');
    const bookingForm = document.getElementById('bookingForm');
    const bookingSuccess = document.getElementById('bookingSuccess');

    if (!modal) return;

    bookingForm.style.display = 'block';
    bookingSuccess.style.display = 'none';

    if (serviceName && serviceSelect) {
        for (let option of serviceSelect.options) {
            if (option.value.toLowerCase().includes(serviceName.toLowerCase())) {
                option.selected = true;
                break;
            }
        }
    }

    if (doctorName && doctorSelect) {
        for (let option of doctorSelect.options) {
            if (option.value.toLowerCase().includes(doctorName.toLowerCase())) {
                option.selected = true;
                break;
            }
        }
    }

    modal.style.display = 'flex';
}

function closeBookingModal() {
    const modal = document.getElementById('bookingModal');
    if (modal) modal.style.display = 'none';
}

function handleBookingSubmit(event) {
    event.preventDefault();

    const service = document.getElementById('modalService').value;
    const doctor = document.getElementById('modalDoctor').value;
    const date = document.getElementById('modalDate').value;
    const time = document.getElementById('modalTime').value;
    const patient = document.getElementById('patientName').value;

    // Generate random confirmation code
    const randomCode = 'PULSE-' + Math.floor(1000 + Math.random() * 9000) + '-' + String.fromCharCode(65 + Math.floor(Math.random() * 26)) + Math.floor(Math.random() * 9);
    
    document.getElementById('confCode').textContent = randomCode;

    // Hide form, show success screen
    document.getElementById('bookingForm').style.display = 'none';
    document.getElementById('bookingSuccess').style.display = 'block';
}

function updateDoctorDropdown() {
    // Dynamic adjustment optional
}

function setTomorrowDateInModal() {
    const dateInput = document.getElementById('modalDate');
    if (dateInput) {
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        dateInput.value = tomorrow.toISOString().split('T')[0];
    }
}

/* -------------------------------------------------------------------------- */
/* Patient Portal Sign In Modal                                               */
/* -------------------------------------------------------------------------- */
function openPortalModal() {
    const modal = document.getElementById('portalModal');
    if (modal) modal.style.display = 'flex';
}

function closePortalModal() {
    const modal = document.getElementById('portalModal');
    if (modal) modal.style.display = 'none';
}

function handlePortalSubmit(event) {
    event.preventDefault();
    const email = document.getElementById('portalEmail').value;
    closePortalModal();
    alert(`Welcome back, Patient ${email}! Telehealth portal session initiated.`);
}

/* Search bar helper */
function searchSpecialists() {
    const spec = document.getElementById('heroSpecialty').value;
    const specSection = document.getElementById('specialists');
    if (specSection) {
        specSection.scrollIntoView({ behavior: 'smooth' });
    }
}
