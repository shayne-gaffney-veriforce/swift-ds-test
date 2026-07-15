import Foundation

extension AppStore {
    /// Seed data transcribed from the sample content in "New app layout (MUi version).fig" —
    /// same worker (Layla Al-Mahdi) and site/client names shown throughout the design.
    public static func seeded() -> AppStore {
        let profile = UserProfile(
            firstName: "Layla",
            lastName: "Al-Mahdi",
            jobTitle: "Engineer",
            dateOfBirth: "1990-10-10",
            email: "layla@xdengineering.com",
            username: "laylam90",
            phone: "438 596-3462",
            extensionNumber: "215",
            address: "3100 Rue Montagne",
            city: "Montreal",
            postalCode: "H3C 1BA",
            country: "Canada",
            workerCardID: "DHB638DHKO"
        )

        let tasks = [
            TaskItem(siteName: "Alcoa", dateRange: "Jun 21 2025 - Jul 21 2025", referenceCode: "AT3638463894", status: .compliant, completionPercent: 100),
            TaskItem(siteName: "2025 Q2 United Rentals Pellet Plant", dateRange: "Jun 21 2025 - Jul 21 2025", referenceCode: "AT3638463894", status: .expiring, completionPercent: 82, assignedCount: 3),
            TaskItem(siteName: "Hydro Quebec Substation", dateRange: "May 1 2025 - Aug 1 2025", referenceCode: "AT3638463901", status: .notCompliant, completionPercent: 45),
            TaskItem(siteName: "Bombardier Assembly Line", dateRange: "Apr 10 2025 - Oct 10 2025", referenceCode: "AT3638463877", status: .compliant, completionPercent: 100)
        ]

        let gateAccess = [
            GateAccessRecord(
                siteName: "Alcoa",
                dateRange: "Jun 21 2025 - Jul 21 2025",
                referenceCode: "AT3638463894",
                status: .compliant,
                requirements: [
                    ComplianceRequirement(title: "Site safety orientation", status: .compliant),
                    ComplianceRequirement(title: "PPE certification", status: .compliant),
                    ComplianceRequirement(title: "Background check", status: .compliant)
                ]
            ),
            GateAccessRecord(
                siteName: "United Rentals Pellet Plant",
                dateRange: "Jun 21 2025 - Jul 21 2025",
                referenceCode: "AT3638463894",
                status: .pending,
                requirements: [
                    ComplianceRequirement(title: "Site safety orientation", status: .compliant),
                    ComplianceRequirement(title: "Confined space training", status: .pending)
                ]
            ),
            GateAccessRecord(siteName: "Hydro Quebec Substation", dateRange: "May 1 2025 - Aug 1 2025", referenceCode: "AT3638463901", status: .blocked),
            GateAccessRecord(siteName: "Bombardier Assembly Line", dateRange: "Apr 10 2025 - Oct 10 2025", referenceCode: "AT3638463877", status: .compliant)
        ]

        let courses = [
            Course(
                title: "Safety around wild animals and insects",
                provider: "Alcumus SafeContractor",
                durationText: "0:30",
                expiresOn: "Jun 21 2025",
                attemptsRemaining: 3,
                status: .created,
                summary: "Knowledge of wild animals and insects is essential to avoid health risks and hazards when working outdoors. In this training course, you will discover some of the animals found in Canada and their characteristics.\n\nYou will learn about preventive measures and safety protocols, in the event of an encounter with a wild animal or insect, and how to respond to an attack."
            ),
            Course(title: "Confined space entry", provider: "Alcumus SafeContractor", durationText: "0:45", expiresOn: "Aug 4 2025", attemptsRemaining: 2, status: .ongoing, summary: "Covers hazard recognition, atmospheric testing, and rescue procedures for confined space entry."),
            Course(title: "Fall protection fundamentals", provider: "Alcumus SafeContractor", durationText: "0:20", expiresOn: "Jan 3 2026", attemptsRemaining: 3, status: .succeeded, summary: "An overview of fall protection equipment and anchor point requirements on active job sites.")
        ]

        let fileRecords = [
            MyFileRecord(category: .qualifications, title: "Working at Heights", clientName: "Alcoa", status: .compliant, expiresOn: "Jun 21 2026"),
            MyFileRecord(category: .qualifications, title: "Confined Space Entry", clientName: "United Rentals", status: .expiring, expiresOn: "Jul 21 2025"),
            MyFileRecord(category: .qualifications, title: "First Aid & CPR", clientName: "Hydro Quebec", status: .notCompliant, expiresOn: "Jan 3 2025"),
            MyFileRecord(category: .training, title: "Safety around wild animals and insects", clientName: "Alcumus SafeContractor", status: .compliant),
            MyFileRecord(category: .training, title: "Confined space entry", clientName: "Alcumus SafeContractor", status: .expiring, expiresOn: "Aug 4 2025")
        ]

        let notifications = [
            AppNotification(
                title: "Site inaccessible due to landslip outside",
                clientName: "Hydro Quebec",
                timeAgo: "1 hour ago",
                subtitle: "Please be aware the site is inaccessible",
                body: "A landslip on the road approaching the factory has made the site inaccessible to all traffic.\n\nAs a precaution, operations in the affected area have been temporarily suspended. Please see the attached map for an alternative route.",
                attachmentNames: ["Map of alternative route.pdf"],
                requiresAcknowledgement: true,
                isRead: false
            ),
            AppNotification(title: "New qualification required for Alcoa", clientName: "Alcoa", timeAgo: "3 hours ago", subtitle: "Confined space entry now required", body: "Alcoa has added a new site requirement effective immediately. Complete the confined space entry course before your next visit.", isRead: false),
            AppNotification(title: "Task assigned: United Rentals Pellet Plant", clientName: "United Rentals", timeAgo: "Yesterday", subtitle: "3 new tasks assigned", body: "You've been assigned 3 new compliance tasks for the United Rentals Pellet Plant project.", isRead: true),
            AppNotification(title: "Certificate approved", clientName: "Bombardier", timeAgo: "2 days ago", subtitle: "Your PPE certification was approved", body: "Your submitted PPE certification has been reviewed and approved by Bombardier's compliance team.", isRead: true)
        ]

        return AppStore(
            profile: profile,
            tasks: tasks,
            gateAccess: gateAccess,
            courses: courses,
            fileRecords: fileRecords,
            notifications: notifications
        )
    }
}
