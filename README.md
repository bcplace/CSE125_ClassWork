<<<<<<< HEAD
# CSE 125/225 Winter 2023 Class Repository

## Getting Started

1. [Fork](https://git.ucsc.edu/drichmond/cse-x25-wi23/-/forks/new) this repository in GitLab, and set the visibility level to *Private*
2. Add the TA(s) and Instructor as *Project Members* 
   - Replace your_username and navigate to: `https://git.ucsc.edu/<your_username>/cse-x25-wi23/-/project_members` OR `https://git.ucsc.edu/<your_username>/cse-x25-wi23/` > Project Information > Members
	 - Click on *Invite Group*
	 - Type In: `cse-x25-wi23-staff`, or (all three) `drichmond`, `pdutta1` and `bharsh`
	 - Click Invite
3. [Clone](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html) `https://git.ucsc.edu/<your_username>/cse-x25-wi23/` repository to your machine

This process ensures that we can push lab assignments to you, and you can push lab solutions to us!


## Repository Structure


The repository has the following file structure:

```bash
| README.md (This File)
├── lab1
│   │   assignment.pdf # Details of Lab Assignment
│   │   README.md # Instructions for running the lab
│   ├── provided_modules
│   │   └── *.sv # pre-written SystemVerilog files
│   ├── part1
│   │   ├── <Module Name 1>
│   │   │   ├── <Module Name>.sv # SystemVerilog Skeleton File
│   │   │   ├── testbench.sv # Testbench for module
│   │   │   └── Makefile # Makefile for running tests
│   │   ├── <Module Name 2>
│   │   │   └── ... # Same files as above
│   │   ├── ...
│   │   └── <Module Name N>
│   ├── part2
│   │   └──  ... # Same structure as part 1
│   ├── ...
│   └── part<X>
├── lab2
│   │   assignment.pdf # Details of Lab Assignment
│   │   README.md # Instructions for running the lab
│   ├── part1
│   ├──...
│   └── part<Y>
├── ...
└── lab<Z>
```

Each lab folder will be available in a branch named `cse-x25-lab<N>`
on the day it is assigned in Canvas (typically around 9 AM PST).
In general, the assignment of each lab will be to complete a set of tasks by completing the SystemVerilog skeleton files. 
Correctness can be tested by simulating the Verilog using the provided makefiles. See `make help` in each module.

In general, the assignment of each lab is to complete several
conceptual parts, each with individual modules.  Each module has a set
of verilog skeleton files that must be completed. Correctness is
verfied by running the testbench using the provided makefile.

Each makefile provides a `make help` command that describes the
available commands.

All labs are due by 11:59:59 PM Pacific Standard Time on the due date
listed in Canvas, typically two weeks after the date they are
assigned.


## CSE 125 (Final Exam Option) Lab Completion

To complete and submit a lab for grading:
	1. Demonstrate correctly simulating code for each part of each
       module to an instructor or TA in one of the lab sections. 
	2. Push your working code to your private fork of this git repository.
	3. Submit the git hash for your working code to Canvas.
    4. Complete the post-lab questionaire on Canvas.
    

## CSE 225 (and CSE 125 + Final Project Option) Lab Completion
	
To complete and submit a lab for grading:
	1. Demonstrate correctly simulating code for each part of each
       module to an instructor or TA in one of the lab sections.
	2. Demonstrate correctly operating code on the FPGA for each
       module that has an FPGA component.
	3. Push your working code to your private fork of this git repository.
	4. Submit the git hash for your working code to Canvas.
    5. Complete the post-lab questionaire on Canvas.

Accomodations will be made in situations specified in the class syllabus.


## CSE 125 (Final Exam Option) Tools

To complete the labs for CSE 125 you will need the following tools:

- *Icarus Verilog*: https://bleyer.org/icarus/ (v10.0)
- *Verilator*: https://verilator.org/guide/latest/index.html (v5.0)
- *GTKWave*: https://gtkwave.sourceforge.net/ (v3.0)

If you use the provided VirtualBox image, these tools will already be
installed. You can install VirtualBox using the instructions here:
https://www.virtualbox.org/wiki/Downloads

You will also need the Oracle VM VirtualBox Extension Pack:
https://www.oracle.com/virtualization/technologies/vm/downloads/virtualbox-downloads.html#extpack

Otherwise you can install these tools using the instructions below.

## CSE 225 (and CSE 125 + Final Project Option)

To complete the labs and project for CSE 225 you will need the CSE 125
tools (above) and the following tools:

- *Yosys*: https://yosyshq.net/yosys/ (v0.23)
- *nextpnr-ice40*: https://github.com/YosysHQ/nextpnr (v0.4)
- *project-icestorm*: https://clifford.at/icestorm (No Version)

If you use the provided VirtualBox image available in Canvas, these
tools will already be installed. You can install VirtualBox using the
instructions here: https://www.virtualbox.org/wiki/Downloads


### Typical Installation - All Operating Systems

Follow these instructions to install the OSS-CAD-Suite, which contains
all the tools: https://github.com/YosysHQ/oss-cad-suite-build#installation

If you are running on Ubuntu, create `/etc/udev/rules.d/50-lattice-ftdi.rules` (you will need to use sudo), and paste the contents: 

    `ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE:="666"`
    
Otherwise you will get the eqivalent of a 'device not found' error when running `iceprog`.


### Advanced Installation - Linux
	
If you like doing things the hard way, you can use these
instructions. Please ensure that you have the correct versions (listed
above).

- On Ubuntu/Debian-like distributions, run: `sudo apt install iverilog verilator gtkwave yosys nextpnr-ice40 fpga-icestorm`

- Then, create `/etc/udev/rules.d/50-lattice-ftdi.rules` (you will need to use sudo), and paste the contents: 

    `ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE:="666"`
    
- Double check your installed tool versions against the ones above.


### Advanced Installation - MacOS

(NB: I use my M2 to write and test the lab assignments. I recommend
the oss-cad-suite above, but this setup works too.)

- Install Homebrew: https://brew.sh/
- Run: `brew install icarus-verilog verilator gtkwave`
- Run: `brew tap ktemkin/oss-fpga`
- Run: `brew install --HEAD icestorm yosys nextpnr-ice40`


### Advanced Installation - Windows

If you are running windows we HIGHLY recommend using the provided
VirtualBox image. 

We will update with WSL instructions when they are available.

=======
# cse-x25-wi23-dev



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://git.ucsc.edu/durichmo/cse-x25-wi23-dev.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://git.ucsc.edu/durichmo/cse-x25-wi23-dev/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thank you to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
>>>>>>> e8d3b47 (Initial commit)
