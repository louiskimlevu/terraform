C:.
├───.github
├───0-bootstrap
│   └───modules
│       └───jenkins-agent
│           └───files
├───1-org
│   └───envs
│       └───shared
├───2-environments
│   ├───envs
│   │   ├───development
│   │   ├───non-production
│   │   └───production
│   └───modules
│       └───env_baseline
├───3-networks
│   ├───envs
│   │   ├───development
│   │   ├───non-production
│   │   ├───production
│   │   └───shared
│   └───modules
│       ├───base_shared_vpc
│       ├───dedicated_interconnect
│       ├───restricted_shared_vpc
│       └───vpn-ha
├───4-projects
│   ├───business_unit_1
│   │   ├───development
│   │   ├───non-production
│   │   └───production
│   ├───business_unit_2
│   │   ├───development
│   │   ├───non-production
│   │   └───production
│   └───modules
│       └───single_project
├───build
└───test
    ├───fixtures
    │   ├───bootstrap
    │   ├───dns_hub
    │   ├───envs
    │   ├───networks
    │   ├───org
    │   └───projects
    ├───integration
    │   ├───bootstrap
    │   │   └───controls
    │   ├───dns_hub
    │   │   └───controls
    │   ├───envs
    │   │   └───controls
    │   ├───networks
    │   │   └───controls
    │   ├───org
    │   │   └───controls
    │   └───projects
    │       └───controls
    └───setup

    