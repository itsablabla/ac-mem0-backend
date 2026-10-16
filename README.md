# Mem0 OSS REST backend (for AgentConnect external memory)

Pinned build of the upstream Mem0 server (commit 42cf18c, SDK 2.0.12) with prod entrypoint (alembic + uvicorn, no reload).

Env: POSTGRES_HOST/PORT/USER/PASSWORD/DB, JWT_SECRET, OPENAI_API_KEY (+ OPENAI_API_BASE for Gemini OpenAI-compat), MEM0_DEFAULT_LLM_MODEL, MEM0_DEFAULT_EMBEDDER_MODEL. Serves :8000.
