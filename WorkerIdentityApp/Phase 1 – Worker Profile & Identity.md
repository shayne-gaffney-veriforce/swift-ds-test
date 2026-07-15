# Phase 1 – Worker Profile & Identity

| Status | IN REVIEW |
| --- | --- |
| Phase | 1 of 3 |
| Business Sponsor | Katie Hill, VP US |
| Product Leadership | Paul Upshaw, SVP Product |
| Product Manager | Julian Berliner, APM |
| Engineering Strategy | Ryan Wischkaemper |
| Engineering Leadership | Aaron Gross |
| Engineering Manager | Eric Burstedt |
| Depends On | GWN Data Layer (EMM – GWN Data Layer, Q2) |
| Enables | Phase 2 – Training Records; Phase 3 – Client Visibility |

## Problem Statement

Veriforce currently has no unified worker identity record. Worker data — names, contact information, credentials, and employment relationships — is fragmented across regional platforms (Compliance Pro, ComplyWorks, VeriSource, and others), with no single source of truth. This makes it impossible to build cross-platform features like training aggregation or client-facing worker lookup without duplicating data and business logic in every region.

Clients, who are ultimately the consumer of worker training credentials, have no unified visibility into what training a worker has completed before performing work on a job site.

Contractors who employ workers have no self-service interface to manage their workforce across the Veriforce platform. Workers themselves have no global visibility into their own data, no ability to correct it, and no portable identity they can carry across contractor relationships. Until this is solved, Phases 2 and 3 cannot be built.

## Goals

1. Establish GWN as the authoritative system of record for worker identity data and contractor–worker associations across all Veriforce platforms.
2. Give contractors a UI to add, edit, deactivate, and invite workers to the platform.
3. Give workers a self-service profile UI where they can view and update their own identity information.
4. Define the canonical worker identity data model in GWN that Phase 2 (training records in EMM) and Phase 3 (client visibility) will build on.
5. Lay the access control foundation — contractor-to-worker ownership and worker-to-self ownership — that governs all downstream data visibility.

## Non-Goals

- **Training records are out of scope for this phase.** The worker profile will have a training section placeholder, but no training data will be surfaced until Phase 2.
- **Client visibility is out of scope for this phase.** Clients cannot look up workers until Phase 3.
- **Migration of existing worker identity records from regional platforms is not required for launch.** New identity records are created in GWN; training record migration into EMM is a Phase 2 dependency and will be scoped separately.
- **SSO/identity federation is not in scope here.** Worker authentication is handled by the OKTA/VF1 initiative; this spec assumes auth exists and focuses on profile data only.
- **Worker credentialing (licenses, certifications) beyond basic identity fields is deferred.** The data model should accommodate it, but the UI for managing credentials is Phase 2+.

## User Stories

### Contractor Admin

- As a contractor admin, I want to see a roster of all workers employed by my company so that I know who is active on the platform and can manage their records.
- As a contractor admin, I want to add a new worker to my roster (manually) so that I can get them into the system before they have a platform account.
- As a contractor admin, I want to invite an existing worker to create a platform login so that they can manage their own profile and eventually access their training records.
- As a contractor admin, I want to edit a worker's identity information so that I can correct errors or update records when details change.
- As a contractor admin, I want to deactivate a worker when they leave my company so that they no longer appear as active on client-facing views.
- As a contractor admin, I want to search and filter my worker roster by name, status, or job role so that I can quickly find specific workers.

### Worker (Self-Service)

- As a worker, I want to view my profile so that I can see what information Veriforce and my employer have on file for me.
- As a worker, I want to edit my personal contact information so that records stay accurate if I change my address, phone, or email.
- As a worker, I want to see which contractors I am currently associated with so that I understand who has visibility into my profile.
- As a worker, I want to see a placeholder for my training records so that I understand what will be available in future phases.

### Platform Admin (Internal)

- As a platform admin, I want to look up any worker by ID or name across all contractors so that I can provide support and troubleshoot data issues.
- As a platform admin, I want to manually link or unlink a worker from a contractor so that I can correct ownership errors without engineering intervention.

## Requirements

### Must-Have (P0)

| Requirement | Acceptance Criteria |
| --- | --- |
| **GWN Worker Record** — A canonical worker identity record exists in the GWN database with a globally unique worker ID. | Each worker has exactly one GWN record. The record is created on first add (by contractor admin or self-registration). Duplicate detection is enforced on email address within a contractor. |
| **Core Identity Fields** — Worker record captures the minimum fields needed to identify an individual. | Required fields: first name, last name, email address, date of birth, employee ID (contractor-assigned). Optional fields: phone, job title, hire date, profile photo. Field-level validation enforced at the API layer. |
| **Contractor–Worker Relationship** — GWN stores the association between a worker and one or more contractors. | A worker can be associated with multiple contractors simultaneously. Each association has an active/inactive status and an effective date. Deactivating an association does not delete the worker record. |
| **Contractor Roster UI** — Contractor admins can view and manage their worker roster in the employee management interface. | Roster displays all active workers with name, email, job title, and status. Supports search by name and filter by status (active/inactive). Paginated for large rosters. Add, edit, deactivate actions available per row. |
| **Add Worker (Manual)** — Contractor admins can add a new worker without requiring the worker to have a platform login. | Admin can enter identity fields and save. Worker record is created in GWN. Worker does not need to exist as a platform user. System checks for duplicate email within that contractor and surfaces a warning. |
| **Edit Worker** — Contractor admins can update the identity fields of any worker in their roster. | All non-immutable fields are editable. Changes are logged with timestamp and actor. Workers are notified by email when their record is edited by an admin (notification is configurable). |
| **Deactivate Worker** — Contractor admins can deactivate a worker, removing them from active roster views without deleting data. | Deactivated workers do not appear in default roster view but are accessible via "show inactive" filter. Deactivation requires a confirmation step. Data is retained; deactivation is reversible. |
| **Invite Worker** — Contractor admins can send a platform invitation to a worker so they can create a login. | Invitation sent to worker's email on file. Invitation link expires after 7 days. Re-send available. If worker already has a platform account (matched by email), admin is informed and no duplicate account is created. |
| **Worker Profile UI** — Workers with a platform login can view their own profile. | Worker sees all identity fields on their GWN record. Clear labeling of which fields were set by contractor vs. self-entered. Read-only view of contractor associations (names only, no contractor admin details). |
| **Worker Self-Edit** — Workers can update their own contact information. | Worker can edit: phone, alternate email, address. Worker cannot edit: primary email (used for login), date of birth, employee ID (contractor-controlled fields). Changes are logged. Contractor admin is notified of worker-initiated changes (configurable). |

### Nice-to-Have (P1)

- **Bulk import** — Contractor admins can upload a CSV of workers to create multiple records at once, with validation and error reporting per row.
- **Worker profile photo** — Workers can upload a headshot that appears on their profile and (eventually) on the client-facing lookup view in Phase 3.
- **Duplicate worker detection across contractors** — If a worker email already exists in GWN under a different contractor, surface a suggestion to link the existing record rather than create a new one.
- **Audit log UI** — Contractor admins can view a change history for each worker record, showing who changed what and when.

### Future Considerations (P2)

- **Worker-initiated contractor association** — Workers can request to be added to a contractor's roster without an admin initiating it (relevant for gig/multi-employer scenarios).
- **Worker data portability** — Workers can export their own profile data (identity + training records from Phase 2) as a portable credential.
- **Identity verification** — Integration with a third-party ID verification service (e.g., document scan) to validate worker identity at onboarding.
- **Worker-to-worker relationship mapping** — Supervisor/subordinate relationships for contractors who need org structure represented.

## Data Model — Key Fields

This is the canonical worker identity schema for GWN. GWN owns identity and contractor–worker associations only. Phase 2 training records live in EMM and reference this record via gwn\_worker\_id — they do not extend this table. Do not design Phase 1 in a way that makes that foreign key join difficult.

| Field | Type | Owner | Notes |
| --- | --- | --- | --- |
| gwn\_worker\_id | UUID | System | Global unique identifier; immutable. Used as FK in EMM training records. |
| first\_name | String | Contractor / Worker | Required |
| last\_name | String | Contractor / Worker | Required |
| primary\_email | String | Worker | Used for platform login; unique within GWN |
| date\_of\_birth | Date | Contractor | Required; not editable by worker |
| employee\_id | String | Contractor | Contractor-assigned; scoped per contractor relationship |
| phone | String | Worker | Optional; worker-editable |
| job\_title | String | Contractor | Optional |
| hire\_date | Date | Contractor | Optional |
| profile\_photo\_url | String | Worker | Optional; P1 |
| status | Enum (active / inactive) | Contractor | Per contractor-worker relationship, not on the global record |
| created\_at | Timestamp | System | Immutable |
| updated\_at | Timestamp | System | Auto-updated |
| Last 4 SSN (Trkr) | String | Contractor / Worker | Optional |
| Candidate ID (VS) | String | System / Worker | Required for migration, once value exists, should be read only |

## Access Control Model

| Actor | Can See | Can Edit |
| --- | --- | --- |
| Contractor Admin | All workers in their contractor's roster | All contractor-owned fields for their workers |
| Worker (self) | Their own full profile | Worker-owned fields only (phone, address) |
| Client | Not in scope — Phase 3 | Not in scope |
| Platform Admin | All workers across all contractors | All fields (support use case) |

## Open Questions

| Question | Owner | Blocking? | Answer |
| --- | --- | --- | --- |
| What fields are required for Phase 3 client lookup? We should confirm with Katie Hill that the Phase 1 identity model captures everything clients will need to see, so we don't have to add fields mid-build. | Katie Hill / Paul | Yes — before finalizing data model | Answered, added Last 4 SSN and CandidateId to table |
| Can a worker be associated with more than one contractor simultaneously on the US platform today? Need to confirm whether multi-contractor is a current reality or a future state we're designing for. | Engineering / Katie Hill | Yes — affects relationship model | Yes, its possible, so we need to cover it. Contractor should not see Employer entered/validated training provided by a different Employer |
| What is the deduplication strategy when a worker email already exists in GWN under a different contractor? Do we merge records, link them, or create separate records? | Engineering / Product | Yes — before data model is finalized | Link them: Identity links to an individual, but an individual can have multiple employers. To the worker, they always retain their data, contractors have access to the data they enter as well as any worker/system owned data, clients will need to be able to look up a worker and see all worker entered, system, and employer entered for connected contractors only. |
| Who owns the primary email field when a worker is shared across contractors? If Contractor A created the record with one email and Contractor B wants to associate the same worker with a different email, how is that resolved? | Engineering / Product | Yes | Paul's thoughts: Identity email is immutable and controlled by the worker exclusively. If a worker with an email identity is added/invited under a different, we should link behind the scenes, but their identity should not change |
| Do we need to accommodate workers who do not have an email address (e.g., field workers without corporate email)? What is the login/invitation flow for them? | Katie Hill / Engineering | No — can resolve during implementation | Must have email address, does not have to be corporate provided email. For their identity, a personal email is better, since it follows them no matter who they work for. Consider future expansion to allow mobile phone number as identity. |
| Should contractor admins be notified when a worker they manage updates their own profile? What's the default (notify vs. silent)? | Product / Katie Hill | No | Not a requirement, but we should record for future consideration. |

## Success Metrics

### Leading Indicators (first 30 days post-launch)

- Contractor roster adoption: % of active contractor accounts that have added at least one worker via the new UI
- Worker invite conversion: % of invited workers who complete profile setup within 7 days
- Worker profile completion rate: % of worker records with all required fields populated
- Error/support ticket volume related to worker data entry

### Lagging Indicators (60–90 days)

- Reduction in support tickets related to worker data discrepancies across platforms
- % of worker identity records in GWN vs. still siloed in regional platforms (baseline for Phase 2 migration readiness)
- Contractor admin satisfaction score on worker management workflow (measured via in-app survey)

## Timeline Considerations

- **Hard dependency:** GWN Data Layer (EMM – GWN Data Layer) must be complete before Phase 1 can begin UI development. Currently targeted Q2.
- **Phase 2 dependency:** The worker identity data model defined here gates Phase 2 scoping. The gwn\_worker\_id must be finalized as the foreign key that EMM training records will reference. Model should be reviewed with engineering before Phase 1 development starts.
- **OKTA/VF1 dependency:** Worker self-service login requires OKTA/VF1 to be live (currently Q4). The contractor-managed roster and manual add/edit flows can ship before workers can log in — consider a phased rollout where contractor features go first.
