# Salesforce Asynchronous Apex Invoice Automation

## Overview

This project demonstrates an **enterprise-style Salesforce automation solution** built using **Asynchronous Apex**, trigger framework architecture, integration patterns, and event-driven processing.

The solution automates invoice processing when an **Opportunity reaches the Closed Won stage**. It asynchronously sends invoice data to an external system, publishes platform events, logs integration errors, and performs scheduled data maintenance.

---

# Business Scenario

When an Opportunity moves to **Closed Won**:

1. The Opportunity trigger detects the status change.
2. The trigger handler delegates processing to the service layer.
3. A Queueable Apex job is created.
4. The Queueable class performs an external invoice API callout.
5. Successful transactions publish a Platform Event.
6. Failed transactions are captured in a custom logging object.

This design demonstrates a scalable Salesforce automation architecture.

---

# Salesforce Architecture

```
OpportunityTrigger
        |
        ↓
OpportunityTriggerHandler
        |
        ↓
OpportunityService
        |
        ↓
InvoiceQueueable
        |
        ↓
External Invoice API
        |
        ↓
Invoice_Event__e
        |
        ↓
Integration_Log__c
```

---

# Features Implemented

## Trigger Framework

Implemented a structured trigger architecture:

- Trigger logic is separated from business logic.
- Trigger handlers control execution flow.
- Service classes contain reusable business processes.
- Improves maintainability and scalability.

---

# Asynchronous Apex Implementation

This project demonstrates multiple asynchronous Apex patterns.

## Queueable Apex

**InvoiceQueueable**

Purpose:
- Processes invoice creation asynchronously.
- Supports HTTP callouts.
- Handles external integration processing.

Benefits:
- Avoids long-running trigger execution.
- Allows complex processing after transactions complete.
- Supports scalable background processing.

---

## Batch Apex

**OpportunityBatchUpdate**

Purpose:
- Performs bulk Opportunity updates.
- Updates closed Opportunities asynchronously.

Implementation:

- Uses `Database.Batchable`.
- Supports processing large data volumes.
- Executes records in manageable batches.

---

## Scheduled Apex

**NightlyOpportunityCleanup**

Purpose:
- Automatically executes batch processing on a schedule.

Example schedule:

```apex
String cron ='0 0 1 * * ?';

System.schedule(
    'Night Job',
    cron,
    new NightlyOpportunityCleanup()
);
```

Runs the Opportunity cleanup process every night.

---

# Integration Architecture

## REST API Callout

The project integrates Salesforce with an external invoice system.

Implementation includes:

- HTTP Request
- HTTP Response handling
- JSON serialization
- Named Credential usage

Example:

```apex
callout:Stripe_Named_Credential/invoices
```

---

# Platform Events

## Invoice_Event__e

Used for event-driven communication.

When an invoice is successfully processed:

```apex
Invoice_Event__e event = new Invoice_Event__e(
    Invoice_Id__c = opp.Id,
    Amount__c = opp.Amount
);

EventBus.publish(event);
```

Benefits:

- Loose coupling between systems.
- Supports scalable event-driven architecture.
- Enables downstream automation.

---

# Error Logging

## Integration_Log__c

The project implements custom integration logging.

Captured information includes:

- Error context
- Error message
- Timestamp

Example:

```apex
insert new Integration_Log__c(
    Context__c = context,
    Error_Message__c = errorMessage,
    Logged_At__c = System.now()
);
```

Benefits:

- Improves troubleshooting.
- Provides integration visibility.
- Creates an audit history.

---

# Apex Components

## Apex Classes

### Trigger Framework

- TriggerHandler
- OpportunityTriggerHandler

### Business Logic

- OpportunityService

### Asynchronous Processing

- InvoiceQueueable
- OpportunityBatchUpdate
- NightlyOpportunityCleanup

### Integration and Logging

- IntegrationLogger
- CustomerApi
- InvoiceRequest

### Testing

- InvoiceCalloutMock

---

# Apex Trigger

## OpportunityTrigger

Responsibilities:

- Detect Opportunity updates.
- Execute handler framework.
- Start asynchronous processing.

---

# Custom Salesforce Metadata

## Custom Objects

Included:

- **Integration_Log__c**
  - Stores integration errors and processing history.

## Platform Events

Included:

- **Invoice_Event__e**
  - Publishes invoice processing events.

---

# Testing Strategy

The project includes testing patterns for:

## HTTP Callouts

Implemented:

- `HttpCalloutMock`

Validates:

- External API responses.
- Successful processing scenarios.
- Error handling.

---

# Salesforce Development Concepts Demonstrated

✅ Apex Trigger Framework  
✅ Service Layer Architecture  
✅ Asynchronous Apex  
✅ Queueable Apex  
✅ Batch Apex  
✅ Scheduled Apex  
✅ REST API Integration  
✅ HTTP Callouts  
✅ Platform Events  
✅ Custom Logging Framework  
✅ Governor Limit Considerations  
✅ Bulk Processing Design  
✅ Apex Testing  

---

# Deployment Requirements

Before deploying, configure:

## Named Credential

Required:

```
Stripe_Named_Credential
```

Used for secure external API communication.

## Metadata Dependencies

The project requires:

- Apex Classes
- Apex Triggers
- Custom Objects
- Platform Events
- Required Fields

---

# Project Structure

```
force-app
|
└── main
    |
    └── default
        |
        ├── classes
        |
        ├── triggers
        |
        └── objects
```

---

# Purpose

This project demonstrates how Salesforce developers can build scalable enterprise solutions using:

- Asynchronous Apex processing
- Trigger framework patterns
- External integrations
- Event-driven architecture
- Salesforce best practices

The goal is to showcase production-style Apex development skills suitable for Salesforce Developer roles.
