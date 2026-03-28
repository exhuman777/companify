-- Companify Global Learning Database Schema
-- Location: ~/.companify/global.db

CREATE TABLE IF NOT EXISTS learnings (
  id INTEGER PRIMARY KEY,
  category TEXT NOT NULL CHECK (category IN (
    'stack-to-role', 'skill-to-role', 'org-pattern', 'custom-skill-reuse', 'general'
  )),
  pattern TEXT NOT NULL,
  confidence REAL DEFAULT 0.5 CHECK (confidence >= 0 AND confidence <= 1),
  confirmed_count INTEGER DEFAULT 1,
  last_seen TEXT DEFAULT (datetime('now')),
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS user_corrections (
  id INTEGER PRIMARY KEY,
  project_name TEXT,
  what_changed TEXT NOT NULL,
  old_value TEXT,
  new_value TEXT,
  correction_count INTEGER DEFAULT 1,
  timestamp TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS skill_matches (
  id INTEGER PRIMARY KEY,
  tech_keyword TEXT NOT NULL,
  skill_slug TEXT NOT NULL,
  source TEXT NOT NULL CHECK (source IN ('local', 'skills.sh', 'custom')),
  hit_count INTEGER DEFAULT 1,
  last_matched TEXT DEFAULT (datetime('now')),
  UNIQUE(tech_keyword, skill_slug)
);

CREATE TABLE IF NOT EXISTS custom_skills (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  created_for_project TEXT,
  reuse_count INTEGER DEFAULT 0,
  content_hash TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS run_history (
  id INTEGER PRIMARY KEY,
  project_name TEXT NOT NULL,
  project_path TEXT,
  org_shape TEXT CHECK (org_shape IN ('flat', 'pipeline', 'hierarchical')),
  agent_count INTEGER,
  skill_count INTEGER,
  duration_ms INTEGER,
  success INTEGER NOT NULL DEFAULT 0,
  timestamp TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS schema_version (
  version INTEGER PRIMARY KEY,
  applied_at TEXT DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO schema_version (version) VALUES (1);
