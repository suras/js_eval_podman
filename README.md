# Node.js Podman Container with Rails Evaluation App

This repository contains a containerized Node.js application using Podman and a Rails evaluation application. This README will guide you through the setup and usage process.

## Prerequisites

- [Podman](https://podman.io/getting-started/installation) (container engine)
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (for Rails)
- [Bundler](https://bundler.io/) (`gem install bundler`)
- [Node.js](https://nodejs.org/) (optional, for local development)

## Project Structure

```
project-root/
├── js_podman_container/   # Contains Node.js app and Dockerfile
│   ├── Dockerfile
│   └── ...
└── js_eval_app/           # Rails application
    ├── Gemfile
    └── ...
```

## Installation & Setup

### 1. Install Podman

Follow the [official Podman installation instructions](https://podman.io/getting-started/installation) for your operating system:

#### Linux (Fedora/RHEL/CentOS):
```bash
sudo dnf install podman
```

#### macOS:
```bash
brew install podman
```

#### Windows:
Download the installer from the [Podman releases page](https://github.com/containers/podman/releases).

### 2. Build the Node.js Container

```bash
cd js_podman_container
podman build -t node-eval-app .
```

### 3. Set Up the Rails Application

```bash
cd ../js_eval_app
bundle install
```

## Running the Applications

### Start the Rails Server

```bash
cd js_eval_app
rails server
```

The Rails application will be available at http://localhost:3000 by default.

