Size of the in-memory cache for transactions the sync service consumes from Postgres over the logical replication stream. Measured in bytes unless one of the following suffixes is used: `k` for KB; `K` for KiB; `m` for MB; `M` for MiB; `g` for GB; `G` for GiB.

This cache is used to quickly catch up connecting clients to the current state in Postgres. If a client's position in the replication stream predates the oldest transaction in the cache.
