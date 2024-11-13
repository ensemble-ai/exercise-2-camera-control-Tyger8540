# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Dillon Mannion
* *email:* dlmannion@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera displays draw_camera_logic automatically and is the expected crosshair. Camera and crosshair are positioned and stay directly on top of the vessel during movement, as described in the assignment. Crosshair logic is processed entirely within draw_logic function, with the ability to turn off with F. Camera movement performs as requested using hyper-speed.

___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Performs assignment requested auto-scrolling function perfectly (at the requested speed of the autoscroll_speed export variable), using both the x and z planes to induce movement if vessel is touching bottom and left box edges. No camera push by the vessel if it is on top and right edges, precluding the vessel from leaving the box as defined in the assignment. Camera is centered on screen with a size using the export variables top_left and bottom_right. The draw_camera_logic flag is automatically set to true on startup, and logic is processed entirely within draw_logic function. Camera movement performs as requested using hyper-speed.

___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera follows vessel at follow_speed which is slower than the vessel, catches up to the vessel if movement has ceased, and does not exceed leash distance at any point. The use of move_towards performs the lerp functionality as described in the assignment. All requested export variables are present and in use. The draw_camera_logic flag is not true on swap, but when true creates the requested crosshair from Stage 1. Crosshair logic is processed entirely within draw_logic function. Camera movement performs as requested using hyper-speed.

___
### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Center of camera leads vessel in direction of player input, approaches the vessel position when vessel has ceased movement for the duration of catchup_delay_duration, and distance between camera and vessel increases as movement does up to the maximum value of leash_distance. Lerp functionality is achieved through use of move_towards function, and a crosshair is drawn when draw_camera_logic is true. All required export variables are present and utilized. The draw_logic function performs all crosshair logic, but the draw_camera_logic flag is initially set to false. Camera movement performs as requested using hyper-speed.

___
### Stage 5 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera moves at the speed of the vessel multiplied by push_ratio in vessel direction when vessel is in between the speedup and pushbox zones, moving, and not touching the pushbox border. Camera moves at the vessel's speed when the vessel is in contact with a cardinal direction edge and at vessel speed times push_ratio on the perpendicular axis direction. If the vessel is in contact with both edges (corner), the camera moves at vessel speed. Camera does not move when going away from outside edges towards center zone and while within speedup zone. Camera produces the push zone borders when draw_camera_logic flag is true, and all required export variables are present and in use. Camera movement performs as requested using hyper-speed.

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.

Following [this](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) style guide.


#### Style Guide Infractions ####
Auto-scroller script had private variables declared [before](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L3) export variables. It should be export, private, onready variables, in that order. [No space](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L32) in front of regular comments. There should be a space in front of regular and documentation comments and no space in front of unused code. Missing blank line after [logic block](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/bed0155e29ebb1096139c4352f7727433fa034cf/Obscura/scripts/camera_controllers/lerp_lead.gd#L33) of code. Code should be seperated by blank lines to indicate logic blocks. This can be seen in many other areas, e.g. [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_follow.gd#L28). Missing [space](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_lead.gd#L9) between name and operator. Operators should be surrounded by a space.
#### Style Guide Exemplars ####
All functions have two [blank line](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L62) separations. [Private](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_lead.gd#L95) functions come at end of script, after public functions. 
___
#### Put style guide infractures ####
1. No space in front of comments, [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L32) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L36)
2. Private variables before export variables [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L3)
3. Logic block separation, [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/bed0155e29ebb1096139c4352f7727433fa034cf/Obscura/scripts/camera_controllers/lerp_lead.gd#L33) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_follow.gd#L28)
4. Missing space before operator, [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_lead.gd#L9) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_lead.gd#L67)
5. Long conditionals not on multiple lines for readability, [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_lead.gd#L48) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_follow.gd#L31)

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as exemplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
I would have liked to see [this](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_follow.gd#L31) line split into multiple line for readability since the conditional was quite long. The comment on the code was hard to find at first because of this, I would suggest putting it above the code. You also forgot to give the autoscroll script a [class name](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L1) in the code, unsure if this is a hard infraction since you don't use the file anywhere, but I thought I would mention it. Otherwise, great code!
#### Best Practices Exemplars ####
Great [use](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L36) of comments to denote what each block of code was calculating, they really helped to break up the long conditionals or assignment lines. Good naming conventions for variables and the [use](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/autoscroll.gd#L31) of blank lines helped to break up logic blocks very well. Your code was very well organized in all scripts. Even when lines had long conditionals, you helped to not make it so busy on the eyes by using spaces or comments. I also liked your [reuse](https://github.com/ensemble-ai/exercise-2-camera-control-Tyger8540/blob/master/Obscura/scripts/camera_controllers/lerp_follow.gd#L22) of the lerp_follow code in the lerp_lead script, don't reinvent the wheel if you don't have to!