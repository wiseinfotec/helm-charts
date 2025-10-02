# Changelog

## [0.1.12] - 2025-10-02

- Fix typo in the pooler mountpath
- Add missed migrations to the initdb

## [0.1.11] - 2025-10-02

- Avoid symlinks in the main function mount volume

## [0.1.10] - 2025-09-21

- Correct database password include in the deployments

## [0.1.9] - 2025-09-19

- Fix using existing secret for db password

## [0.1.8] - 2025-09-18

- Fix typo in the db secret key
- Comment external secret refs in the value file
- Add realtime DB_ENC_KEY from secret
- Adjust secrets grouping

## [0.1.7] - 2025-09-18

- Fix "cannot unmarshal object into Go struct" error for supabase/realtime deployment

## [0.1.6] - 2025-09-08

- Add readinessProbe for supabase/realtime deployment

## [0.1.5] - 2025-09-02

- Optimize init-db container
- Adjust DB related env and reduce their duplication
- Add some missed ENV variables as well as replace deprecated one
- Add release namespace to the template files
- Add supabase/supervisor image deployment
- Add some pods healthcheck

## [0.1.4] - 2025-07-27

Merging some pull requests from [original](https://github.com/supabase-community/supabase-kubernetes) repository:

- <https://github.com/supabase-community/supabase-kubernetes/pull/62>
- <https://github.com/supabase-community/supabase-kubernetes/pull/89>
- <https://github.com/supabase-community/supabase-kubernetes/pull/91>
- <https://github.com/supabase-community/supabase-kubernetes/pull/94>
- <https://github.com/supabase-community/supabase-kubernetes/pull/95>
- <https://github.com/supabase-community/supabase-kubernetes/pull/96>
- <https://github.com/supabase-community/supabase-kubernetes/pull/101>
- <https://github.com/supabase-community/supabase-kubernetes/pull/106>
- <https://github.com/supabase-community/supabase-kubernetes/pull/107>
- <https://github.com/supabase-community/supabase-kubernetes/pull/113>

## [0.1.3] - 2025-07-27

- Initial release (cloned from [supabase-community/supabase-kubernetes](https://github.com/supabase-community/supabase-kubernetes))
