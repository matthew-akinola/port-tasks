PORT SUPPORT ENGINEER ASSIGNMENT - SOLUTION DOCUMENT

Candidate: Matthew Akinola


EXERCISE #1: JQ PATTERNS FOR API RESPONSE TRANSFORMATION


SOLUTION OVERVIEW:
Successfully created JQ patterns to extract specific information from Kubernetes deployment objects and Jira API responses. All patterns were tested and validated using JQPlay.

1.1 KUBERNETES DEPLOYMENT OBJECT EXTRACT
TASK: Extract information from K8s deployment object snippet

JQ PATTERNS DEVELOPED:

a) Current replica count:
   Pattern: .spec.replicas
   Result: Returns the number of replicas: 1

b) Deployment strategy:
   Pattern: .spec.strategy.type
   Result: Returns strategy type: "RollingUpdate"

c) Service-Environment label concatenation:
   Pattern: (.metadata.labels.service + "-" + .metadata.labels.environment)
   Result: Returns concatenated string: "authorization-production-gcp-1”

VALIDATION:
- All patterns tested successfully in JQPlay
- Results confirmed against provided deployment JSON

![JQPlay K8s Patterns](screenshots/jq-deployment.png)






1.2 JIRA API SUBTASK EXTRACTION

TASK: Extract all subtask issue IDs from Jira API response

JQ PATTERN DEVELOPED:
Pattern: [.fields.subtasks[].key]
Result: Returns array of subtask IDs

VALIDATION:
- Pattern tested in JQPlay with provided Jira JSON
- Successfully extracted 13 subtask IDs from the sample data

![JQPlay Jira Subtasks](screenshots/jq-jira.png)





EXERCISE #2: PORT-JIRA-GITHUB INTEGRATION SETUP

SOLUTION OVERVIEW:
Successfully implemented end-to-end integration between Port, Jira, and GitHub with proper data model relationships and component mapping.

2.1 INITIAL SETUP COMPLETED
 Logged into Port using provided credentials
Installed Port's GitHub App with proper permissions
GitHub repositories automatically imported into Port
Repository blueprint created automatically

![Port GitHub Integration](screenshots/catalog-github.png)



2.2 JIRA ACCOUNT AND PROJECT SETUP

Created free Jira account (akinolatolulope24.atlassian.net)
 Created new project with specifications:
  Category: Software Development
  Template: Scrum
  Type: Company Managed Project (for components access)
  Project Key: PORT

 Created Jira components matching GitHub repositories:
Component 1: "ec2-finOps" (matches GitHub repo)
Component 2: "rentrite-infra-gitOps" (matches GitHub repo)




2.3 PORT OCEAN JIRA INTEGRATION
Installed Jira Ocean integration using "Scheduled" method
Configured integration with GitHub workflow deployment
Integration configuration:
  - Type: Scheduled (every hour) and workflow dispatch (for manual triggering)
  - Deployment: GitHub Actions workflow
  - Authentication: Jira API token and user email




2.4 DATA MODEL RELATIONSHIP CREATION
Navigated to Port Builder
Located "Jira Issue" blueprint
Added relation to "Repository" blueprint with configuration:
  - Title: Repository
  - Identifier: github_repo_relation
  - Type: Relation
  - Related to: Repository
  - Limit: (empty for many-to-many)
  - Required: No



2.5 INTEGRATION TESTING AND VALIDATION
Created test Jira issue "PORT-1" with title "Port Task 2"
Assigned both components to the issue:
  - ec2-finOps
  - rentrite-infra-gitOps
Triggered integration sync
Verified successful data mapping

FINAL RESULT VALIDATION:
Integration successfully created Jira issue entity with proper relations:
- Issue ID: PORT-1
- Components mapped to repositories: ["ec2-finOps", "rentrite-infra-gitOps"]
- Many-to-many relationship working correctly

![Jira Project Setup](screenshots/jira-project.png)

![Jira Components](screenshots/jira-project-component.png)

![Port Jira Integration](screenshots/port-jira-int.png)

![Jira Issue in Port](screenshots/port-jira-issue.png)





EXERCISE #3: REPOSITORY PR SCORECARD IMPLEMENTATION

SOLUTION OVERVIEW:
Successfully implemented a scorecard system that tracks open pull requests per repository with Gold/Silver/Bronze scoring logic.

3.1 REPOSITORY BLUEPRINT PROPERTY ADDITION
Navigated to Port Builder → Repository blueprint
Added new property with configuration:
  - Title: Open PRs Count
  - Identifier: openPRsCount
  - Type: Number
  - Description: Number of open pull requests in the repository
  - Required: No
  - Default Value: 0

![Repository Blueprint Property](screenshots/operPRCount.png)


3.2 GITHUB INTEGRATION MAPPING UPDATE
Updated GitHub integration mapping to include PR count:
yaml
properties:
  openPRsCount: .open_issues_count


Mapping successfully captures open PR count from GitHub API
Integration tested and validated with repository data

VALIDATION RESULT:
Repository entity showing correct PR count:
Repository: 
matthew-akinola/ATM-operation-with-python
matthew-akinola/rentrite-infra-gitOps
openPRsCount: 0 (initially, before test PRs created)



3.3 SCORECARD CREATION AND CONFIGURATION

Created new scorecard "Repository PR Management"
Applied to Repository blueprint
Configured scoring levels:
   SCORECARD STRUCTURE:
- Bronze (Base level): 10+ open PRs
- Silver: < 10 open PRs  
- Gold: < 5 open PRs
   RULES CONFIGURATION:
- Gold Rule: openPRsCount < 5
- Silver Rule: openPRsCount < 10
- Bronze: Default level (no rule required)

![Scorecard Configuration](screenshots/port-scorecard.png)

![Scorecard Rules](screenshots/port-scorecard-2.png)

![Scorecard Results](screenshots/port-scorecard-3.png)



3.4 SCORECARD TESTING AND VALIDATION

Created test pull requests in GitHub repository
Triggered integration sync
Verified scorecard evaluation

FINAL VALIDATION:
Repository "rentrite-infra-gitOps" with 6 open PRs:
- openPRsCount: 6
- Scorecard Level: Silver (correctly evaluated as < 10 PRs)
- Rules Status: Gold rule failed, Silver rule passed
Repository “ec2-finOps” with 2 open PRs:
 - openPRsCount: 2
- Scorecard Level: Gold (correctly evaluated as < 5 PRs)
- Rules Status: Gold rule passed











EXERCISE #4: GITHUB WORKFLOW TROUBLESHOOTING GUIDE

4.1 PROBLEM ANALYSIS FRAMEWORK
Identified the core issue: "IN PROGRESS" status indicates Port sent the trigger successfully, but either:
1. Workflow never started (configuration issue)
2. Workflow started but never completed (workflow issue)  
3. Workflow completed but didn't report back (communication issue)

4.2 SYSTEMATIC TROUBLESHOOTING APPROACH DEVELOPED
PHASE 1: Port Action Configuration
- Backend type verification (must be "GITHUB")
- Repository format validation (owner/repo, not full URL)
- Workflow filename accuracy (including .yml extension)
- Input parameter matching

PHASE 2: GitHub App & Permissions
- Installation verification on correct repositories
- Required permissions checklist (Actions: write, Contents: read)
- Repository accessibility validation

PHASE 3: GitHub Workflow Configuration  
- File location verification (.github/workflows/)
- workflow_dispatch trigger requirement
- YAML syntax validation
- Input parameter alignment

![GitHub Workflow Integration](screenshots/jira-git-workflow.png)

![Workflow Configuration](screenshots/jira-git-workflow2.png)


