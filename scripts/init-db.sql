-- Companify Per-Company Database Schema
-- Location: {project}/.companify/company.db

CREATE TABLE IF NOT EXISTS agents (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  title TEXT NOT NULL,
  reports_to TEXT REFERENCES agents(slug),
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'paused', 'archived')),
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS skills (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  source TEXT NOT NULL CHECK (source IN ('local', 'skills.sh', 'custom', 'builtin')),
  source_path TEXT,
  installed_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS agent_skills (
  agent_id INTEGER REFERENCES agents(id) ON DELETE CASCADE,
  skill_id INTEGER REFERENCES skills(id) ON DELETE CASCADE,
  PRIMARY KEY (agent_id, skill_id)
);

CREATE TABLE IF NOT EXISTS teams (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  manager_agent_id INTEGER REFERENCES agents(id),
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS team_members (
  team_id INTEGER REFERENCES teams(id) ON DELETE CASCADE,
  agent_id INTEGER REFERENCES agents(id) ON DELETE CASCADE,
  PRIMARY KEY (team_id, agent_id)
);

CREATE TABLE IF NOT EXISTS runs (
  id INTEGER PRIMARY KEY,
  timestamp TEXT DEFAULT (datetime('now')),
  phase TEXT NOT NULL,
  duration_ms INTEGER,
  success INTEGER NOT NULL DEFAULT 0,
  error_log TEXT
);

CREATE TABLE IF NOT EXISTS validations (
  id INTEGER PRIMARY KEY,
  run_id INTEGER REFERENCES runs(id),
  file_path TEXT NOT NULL,
  check_name TEXT NOT NULL,
  passed INTEGER NOT NULL DEFAULT 0,
  error_detail TEXT,
  timestamp TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS memories (
  id INTEGER PRIMARY KEY,
  agent_slug TEXT NOT NULL,
  key TEXT NOT NULL,
  value TEXT,
  updated_at TEXT DEFAULT (datetime('now')),
  UNIQUE(agent_slug, key)
);

CREATE TABLE IF NOT EXISTS schema_version (
  version INTEGER PRIMARY KEY,
  applied_at TEXT DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO schema_version (version) VALUES (1);
