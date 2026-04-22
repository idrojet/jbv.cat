import projects from './projects.js';

// ─── Typing effect ───────────────────────────────────────

const titles = [
  "Desenvolupador autodidacta",
  "Constructor d'eines digitals",
  "Linux · Python · n8n",
];

let titleIndex = 0;
let charIndex = 0;
let isDeleting = false;

function type() {
  const el = document.getElementById('typing-text');
  if (!el) return;

  const current = titles[titleIndex];

  if (isDeleting) {
    el.textContent = current.slice(0, --charIndex);
  } else {
    el.textContent = current.slice(0, ++charIndex);
  }

  let delay = isDeleting ? 40 : 80;

  if (!isDeleting && charIndex === current.length) {
    delay = 2200;
    isDeleting = true;
  } else if (isDeleting && charIndex === 0) {
    isDeleting = false;
    titleIndex = (titleIndex + 1) % titles.length;
    delay = 400;
  }

  setTimeout(type, delay);
}

// ─── Render projects ─────────────────────────────────────

const STATUS_LABEL = {
  done:        'Fet',
  'in-progress': 'En curs',
  pending:     'Pendent',
};

const STATUS_CLASS = {
  done:        'status-done',
  'in-progress': 'status-in-progress',
  pending:     'status-pending',
};

function renderProjects(filter = 'all') {
  const grid = document.getElementById('projects-grid');
  if (!grid) return;

  grid.innerHTML = '';

  const filtered = filter === 'all'
    ? projects
    : projects.filter(p => p.status === filter);

  if (filtered.length === 0) {
    grid.innerHTML = '<p style="color:var(--text-muted);font-size:var(--fs-sm)">Cap projecte en aquesta categoria.</p>';
    return;
  }

  filtered.forEach(p => {
    const card = document.createElement('article');
    card.className = 'project-card reveal';

    const repoEl = p.private
      ? `<span class="project-link project-link--private">⌥ Repo privat</span>`
      : p.repo
        ? `<a href="${p.repo}" class="project-link" target="_blank" rel="noopener">⌥ Repo</a>`
        : '';

    const links = [
      p.url ? `<a href="${p.url}" class="project-link" target="_blank" rel="noopener">↗ Web</a>` : '',
      repoEl,
    ].filter(Boolean).join('');

    card.innerHTML = `
      <div class="project-card-header">
        <h3 class="project-title">${p.title}</h3>
        <span class="project-status ${STATUS_CLASS[p.status]}">${STATUS_LABEL[p.status]}</span>
      </div>
      <p class="project-desc">${p.description}</p>
      <div class="project-tags">
        ${p.tags.map(t => `<span class="project-tag">${t}</span>`).join('')}
      </div>
      ${links ? `<div class="project-links">${links}</div>` : ''}
    `;

    grid.appendChild(card);
  });

  observeReveal();
}

// ─── Filters ─────────────────────────────────────────────

function initFilters() {
  const buttons = document.querySelectorAll('.filter-btn');
  buttons.forEach(btn => {
    btn.addEventListener('click', () => {
      buttons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      renderProjects(btn.dataset.filter);
    });
  });
}

// ─── Scroll reveal ───────────────────────────────────────

function observeReveal() {
  const io = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        entry.target.style.transitionDelay = `${i * 60}ms`;
        entry.target.classList.add('visible');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.reveal').forEach(el => io.observe(el));
}

// ─── Active nav on scroll ────────────────────────────────

function initNavHighlight() {
  const sections = document.querySelectorAll('section[id]');
  const links    = document.querySelectorAll('.nav-links a');

  const io = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        links.forEach(l => l.classList.remove('active'));
        const active = document.querySelector(`.nav-links a[href="#${entry.target.id}"]`);
        if (active) active.classList.add('active');
      }
    });
  }, { rootMargin: '-40% 0px -55% 0px' });

  sections.forEach(s => io.observe(s));
}

// ─── Email anti-spam ─────────────────────────────────────

function initEmail() {
  const link = document.getElementById('contact-email');
  const text = document.getElementById('contact-email-text');
  if (!link || !text) return;

  const addr = ['jordi', 'boixader.com'].join('@');
  link.href = 'mailto:' + addr;
  text.textContent = addr;
}

// ─── Init ────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', () => {
  type();
  renderProjects();
  initFilters();
  observeReveal();
  initNavHighlight();
  initEmail();
});
