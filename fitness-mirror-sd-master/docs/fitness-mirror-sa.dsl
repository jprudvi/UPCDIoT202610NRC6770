workspace "Smart Fitness Mirror Platform" "A software platform for an IoT-based Smart Fitness Mirror with edge AI coaching, cloud analytics, and Stripe integration" {
    model {
        visitor = person "Visitor" "Anonymous user who browses public website content and may sign up or apply as a coach." "Visitor"
        fitnessUser = person "Fitness User" "Uses the Smart Fitness Mirror to train and track fitness progress."
        fitnessCoach = person "Fitness Coach" "Provides exercise and technique data for ML model training."
        techSupport = person "Technical Support Staff Member" "Monitors system performance and handles maintenance."
        rndTeam = person "R&D Team Member" "Analyzes trends and improves the platform."
        platformOwner = person "Platform Owner" "Approves high-level decisions and reviews business strategic analytics."
        crmStaff = person "Platform CRM Staff Member" "Manages subscriptions, equipment renting, and customer support."
        stripe = softwareSystem "Stripe" "Processes monthly/annual subscription and equipment renting payments." "External"
        mirrorHardware = softwareSystem "Smart Mirror Hardware" "Physical device with camera, sensors, and display." "External, Hardware"
        smartFitnessPlatform = softwareSystem "Smart Fitness Mirror Platform" "IoT-based fitness platform with edge AI coaching, cloud analytics, and CRM." {
            embeddedApp = container "Smart Mirror Embedded Application" "Embedded software controlling the Smart Mirror hardware." "C++" "IoT" {
                deviceController = component "Device Controller" "Interfaces with camera, sensors, and display." "C++"
                sessionManager = component "Session Manager" "Manages training session data and streams." "C++"
            }
            edgeApp = container "Fitness Local Station Edge Application" "Edge software for AI coaching and analytics." "Python" "Edge" {
                aiCoach = component "AI Coach" "Analyzes session data using a local ML model to provide recommendations." "Python"
                localMLModel = component "Local ML Model" "Pre-trained ML model refined with user data." "TensorFlow Lite"
                edgeAnalytics = component "Edge Analytics" "Generates anonymous summary data and trends." "Python"
                trainingPlans = component "Training Plans" "Manages available training plans." "Python"
                localFileSystem = component "Local File System" "Stores media like video recordings." "File System" "FileSystem"
            }
            edgeDB = container "Edge SQLite Database" "Stores structured data like recommendations and plans on the edge (SQLite)." "SQLite" "Database"
            mobileApp = container "Mobile Application" "Allows users to review analytics, recommendations, training plans, share achievements, and join group sessions." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "MobileApp" {
                mobileFacade = component "Mobile Facade" "Simplifies interactions with edge services for UI components." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "Facade"
                analyticsUI = component "Analytics UI" "Displays user performance and trends." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "UI"
                recommendationsUI = component "Recommendations UI" "Displays AI-generated recommendations." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "UI"
                trainingPlansUI = component "Training Plans UI" "Displays available training plans." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "UI"
                socialSharing = component "Social Sharing" "Enables sharing achievements." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)" "UI"
                groupSession = component "Group Session" "Manages remote group training sessions." "Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android), WebRTC" "UI"
            }
            mobileDB = container "Mobile SQLite Database" "Stores a subset of user data for performance on the mobile device (SQLite)." "SQLite" "Database"
            website = container "Fitness Mirror Platform Website" "Serves the fitness platform's web application content." "TypeScript, Angular" "Server" {
                staticContent = component "Static Content" "Serves Angular PWA files." "TypeScript, Angular"
            }
            webClientApp = container "Fitness Mirror Platform Web Client App" "Client-side fitness application executed in the user's browser." "TypeScript, Angular" "Browser" {
                dashboardUI = component "Dashboard UI" "Displays analytics, trends, and subscription info." "TypeScript, Angular"
                adminUI = component "Admin UI" "Manages subscriptions and system oversight." "TypeScript, Angular"
            }
            apiGateway = container "API Gateway" "Routes requests to microservices." "AWS API Gateway" "Gateway"
            iamService = container "IAM Service" "Manages user authentication, authorization, and identity." "Java, Spring Boot" "Microservice" {
                iamLogic = component "IAM Logic" "Handles authentication, authorization, and user management." "Java, Spring Boot"
            }
            iamDB = container "IAM PostgreSQL Database" "Stores user credentials, roles, and tokens." "PostgreSQL" "Database"
            performanceService = container "Performance Service" "Manages system performance data." "Java, Spring Boot" "Microservice" {
                performanceLogic = component "Performance Logic" "Processes performance data." "Java, Spring Boot"
            }
            performanceDB = container "Performance Oracle Database" "Stores system performance data (Oracle)." "Oracle" "Database"
            trendsService = container "Trends Service" "Manages exercise and technique trends." "Java, Spring Boot" "Microservice" {
                trendsLogic = component "Trends Logic" "Processes trend data." "Java, Spring Boot"
            }
            trendsDB = container "Trends Oracle Database" "Stores exercise and technique trends (Oracle)." "Oracle" "Database"
            subscriptionService = container "Subscription Service" "Manages user subscriptions and renting." "Java, Spring Boot" "Microservice" {
                subscriptionLogic = component "Subscription Logic" "Handles subscription and payment processing." "Java, Spring Boot"
            }
            subscriptionDB = container "Subscription Oracle Database" "Stores subscription and renting data (Oracle)." "Oracle" "Database"
            analyticsService = container "Analytics Service" "Generates business-level insights." "Java, Spring Boot" "Microservice" {
                analyticsLogic = component "Analytics Logic" "Generates strategic insights." "Java, Spring Boot"
            }
            analyticsDB = container "Analytics Oracle Database" "Stores analytics data (Oracle)." "Oracle" "Database"
            visitor -> website "Browses public content (landing page, plans information)"
            visitor -> iamService "Signs up or applies to become a user or coach"
            visitor -> fitnessUser "Signs up via IAM to become a Fitness User"
            visitor -> fitnessCoach "Applies via IAM to become a Fitness Coach"
            embeddedApp -> mirrorHardware "Controls and retrieves data from camera, sensors, and display"
            embeddedApp -> edgeApp "Sends session data and receives recommendations"
            edgeApp -> edgeDB "Stores and retrieves data"
            edgeApp -> mobileApp "Syncs user data, recommendations, training plans, and session streams"
            edgeApp -> apiGateway "Sends anonymous summary data and trends"
            mobileApp -> edgeApp "Retrieves analytics, recommendations, and training plans via Mobile Facade"
            mobileApp -> embeddedApp "Controls group sessions"
            mobileApp -> mobileDB "Caches and retrieves local data"
            mobileApp -> apiGateway "Accesses cloud services"
            mobileApp -> iamService "Authenticates users"
            website -> iamService "Handles sign-up and login requests"
            webClientApp -> website "Fetches PWA files"
            webClientApp -> apiGateway "Interacts with cloud services"
            webClientApp -> iamService "Authenticates users and authorizes access"
            apiGateway -> iamService "Routes authentication and authorization requests"
            apiGateway -> performanceService "Routes performance data"
            apiGateway -> trendsService "Routes trends data"
            apiGateway -> subscriptionService "Routes subscription requests"
            apiGateway -> analyticsService "Routes analytics requests"
            iamService -> iamDB "Stores and retrieves user credentials, roles, and tokens"
            iamService -> subscriptionService "Links new users to subscriptions"
            performanceService -> performanceDB "Stores and retrieves performance data"
            trendsService -> trendsDB "Stores and retrieves trends data"
            subscriptionService -> subscriptionDB "Stores and retrieves subscription data"
            subscriptionService -> stripe "Processes payments"
            analyticsService -> analyticsDB "Stores and retrieves analytics data"
            analyticsService -> trendsService "Fetches trends data via API"
            analyticsService -> performanceService "Fetches performance data via API"
            fitnessUser -> mobileApp "Uses for training and reviews data"
            fitnessUser -> webClientApp "Reviews analytics and manages account"
            fitnessCoach -> webClientApp "Provides exercise/technique data via UI"
            techSupport -> webClientApp "Monitors system performance"
            rndTeam -> webClientApp "Analyzes trends for R&D"
            platformOwner -> webClientApp "Reviews strategic analytics and approves decisions"
            crmStaff -> webClientApp "Manages subscriptions and renting, provides support"
            crmStaff -> stripe "Initiates payment processing"
            platformOwner -> stripe "Oversees payment operations"
            deviceController -> mirrorHardware "Captures video, motion data, and sends output to display"
            sessionManager -> deviceController "Coordinates session data"
            sessionManager -> edgeApp "Sends session data"
            aiCoach -> sessionManager "Receives session data"
            aiCoach -> localMLModel "Uses and refines"
            aiCoach -> trainingPlans "Uses to guide recommendations"
            aiCoach -> deviceController "Sends recommendations to display"
            aiCoach -> edgeDB "Stores recommendations"
            trainingPlans -> edgeDB "Stores training plans"
            localFileSystem -> aiCoach "Stores video recordings"
            edgeAnalytics -> localFileSystem "Reads data for analysis"
            edgeAnalytics -> edgeDB "Reads data for analysis"
            edgeAnalytics -> apiGateway "Sends anonymous data to Trends and Performance Services"
            mobileFacade -> edgeApp "Fetches analytics, recommendations, plans, and shares achievements"
            analyticsUI -> mobileFacade "Requests user analytics"
            analyticsUI -> mobileDB "Caches analytics locally"
            recommendationsUI -> mobileFacade "Requests AI recommendations"
            recommendationsUI -> mobileDB "Caches recommendations locally"
            trainingPlansUI -> mobileFacade "Requests training plans"
            trainingPlansUI -> mobileDB "Caches training plans locally"
            socialSharing -> mobileFacade "Shares achievements"
            groupSession -> embeddedApp "Streams group session video"
            staticContent -> webClientApp "Delivers PWA files"
            dashboardUI -> apiGateway "Fetches analytics and trends"
            adminUI -> apiGateway "Manages subscriptions and system data"
            iamLogic -> iamDB "Manages user data"
            performanceLogic -> performanceDB "Stores and retrieves data"
            trendsLogic -> trendsDB "Stores and retrieves data"
            subscriptionLogic -> subscriptionDB "Stores and retrieves data"
            subscriptionLogic -> stripe "Processes payments"
            analyticsLogic -> analyticsDB "Stores and retrieves data"
            analyticsLogic -> trendsService "Fetches trends data via API"
            analyticsLogic -> performanceService "Fetches performance data via API"
        }
    }
    views {
        systemContext smartFitnessPlatform "SystemContext" {
            include *
            autoLayout
        }
        container smartFitnessPlatform "ContainerView" {
            include *
            autoLayout
        }
        component embeddedApp "EmbeddedAppComponents" {
            include *
            autoLayout
        }
        component edgeApp "EdgeAppComponents" {
            include *
            autoLayout
        }
        component mobileApp "MobileAppComponents" {
            include *
            autoLayout
        }
        component website "WebsiteComponents" {
            include *
            autoLayout
        }
        component webClientApp "WebClientAppComponents" {
            include *
            autoLayout
        }
        component iamService "IAMServiceComponents" {
            include *
            autoLayout
        }
        component performanceService "PerformanceServiceComponents" {
            include *
            autoLayout
        }
        component trendsService "TrendsServiceComponents" {
            include *
            autoLayout
        }
        component subscriptionService "SubscriptionServiceComponents" {
            include *
            autoLayout
        }
        component analyticsService "AnalyticsServiceComponents" {
            include *
            autoLayout
        }
        styles {
            element "Element" {
            color darkcyan
            stroke darkcyan
            strokeWidth 7
            shape RoundedBox
            }
            element "Person" {
                shape Person
            }
            element "Visitor" {
                shape Person
                background gray
                stroke gray
                color white
            }
            element "Software System" {

            }
            element "Container" {

            }
            element "Database" {
                shape Cylinder
            }
            element "Microservice" {
                shape Hexagon
            }
            element "MobileApp" {
                shape MobileDeviceLandscape
            }
            element "FileSystem" {
                shape Folder
            }
            element "IoT" {
                shape RoundedBox
            }
            element "Browser" {
                shape WebBrowser
            }
            element "Component" {

            }
            element "Facade" {

            }
            element "UI" {

            }
            element "External" {
                color white
                stroke darkgray
                background darkgray
            }
            element "Hardware" {

            }
        }
    }
}