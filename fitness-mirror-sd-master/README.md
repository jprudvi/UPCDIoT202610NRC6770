# Fitness Mirror Project

## Overview
This is a software platform for an IoT-based Smart Fitness Mirror. It features edge AI coaching, cloud analytics, and Stripe payment integration, supporting fitness users, coaches, and platform staff. The platform includes a native mobile app (iOS: Swift/SwiftUI, Android: Kotlin/Jetpack Compose), a TypeScript/Angular PWA, and Java/Spring Boot microservices.

This repository contains architecture documentation using the C4 Model, visualized via Structurizr DSL and PlantUML diagrams.

## Project Structure
- `LICENSE.md`: MIT License, authored by IoT Solution Development Team.
- `README.md`: This file.
- `docs/`:
  - `fitness-mirror-sa.dsl`: Structurizr DSL defining the C4 Model (System Context, Container, Component levels).
  - `fitness-mirror-sa-system-context.puml`: PlantUML code for the System Context diagram.
  - `fitness-mirror-sa-container.puml`: PlantUML code for the Container diagram.
  - `fitness-mirror-sa-component-mobile-iam.puml`: PlantUML code for the Mobile App and IAM Service component diagram.
  - `user-stories.md`: User stories and acceptance criteria for platform features.

## Architecture Highlights
- **Authors**: IoT Solution Development Team.
- **Actors**: Visitor (browses website), Fitness User (trains), Fitness Coach (provides data), Tech Support, R&D Team, Platform Owner, CRM Staff.
- **Systems**:
  - Smart Fitness Mirror Platform: IoT platform with edge (`edgeApp`, Python), embedded (`embeddedApp`, C++), and cloud components.
  - External: Stripe (payments), Smart Mirror Hardware (camera, sensors, display).
- **Key Containers**:
  - Mobile App: Native iOS/Android with a Facade pattern for edge interactions.
  - Website & Web Client App: TypeScript/Angular PWA for public and authenticated access.
  - Microservices: Java/Spring Boot for IAM, subscriptions, analytics, trends, performance.
  - Databases: SQLite (edge, mobile), PostgreSQL (IAM), Oracle (cloud services).
- **Key Features**:
  - Edge AI coaching (`aiCoach`, TensorFlow Lite).
  - Group sessions via WebRTC (`groupSession`).
  - Visitor conversion via IAM (`visitor -> iamService`).

## Usage
### Structurizr DSL
1. Open `docs/fitness-mirror-sa.dsl` in Structurizr (https://structurizr.com).
2. Paste the DSL into a workspace (e.g., https://structurizr.com/workspace/82625/dsl).
3. View diagrams: SystemContext, ContainerView, Component views (e.g., MobileAppComponents).

### PlantUML Diagrams
1. Open one of these files in a PlantUML editor (https://www.plantuml.com/plantuml):
   - `docs/fitness-mirror-sa-system-context.puml`
   - `docs/fitness-mirror-sa-container.puml`
   - `docs/fitness-mirror-sa-component-mobile-iam.puml`
2. Render each diagram independently.
3. Alternatively, use VS Code with the PlantUML extension and C4-PlantUML (https://github.com/plantuml-stdlib/C4-PlantUML).

### User Stories
1. Review `docs/user-stories.md` to understand platform requirements.
2. Use the stories as a guide in software lifecycle, like development, testing, or stakeholder discussions.

## Rendering Tips
- **Structurizr**: Clear browser cache (Ctrl+Shift+R) if parsing errors occur.
- **PlantUML**: Ensure C4-PlantUML is included (via `!include` statements).
- **Dependencies**: For local PlantUML rendering, install Java and Graphviz.

## License
This project is licensed under the MIT License. See `LICENSE.md` for details.

## Authors
- **IoT Solution Development Team**