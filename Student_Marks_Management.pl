% ======================================
% Student Performance Knowledgebase in Prolog
% ======================================

% -------------------------------
% FACTS
% -------------------------------

% student(Name).
student(mamun).
student(samia).
student(rakib).
student(anika).
student(raihan).

% subject(Name).
subject(math).
subject(english).
subject(physics).
subject(ict).
subject(chemistry).

% marks(Student, Subject, Mark).
marks(mamun, math, 85).
marks(mamun, english, 72).
marks(mamun, physics, 65).
marks(mamun, ict, 88).
marks(mamun, chemistry, 75).

marks(samia, math, 40).
marks(samia, english, 60).
marks(samia, physics, 55).
marks(samia, ict, 58).
marks(samia, chemistry, 62).

marks(rakib, math, 30).
marks(rakib, english, 25).
marks(rakib, physics, 45).
marks(rakib, ict, 35).
marks(rakib, chemistry, 40).

marks(anika, math, 95).
marks(anika, english, 90).
marks(anika, physics, 92).
marks(anika, ict, 94).
marks(anika, chemistry, 96).

marks(raihan, math, 55).
marks(raihan, english, 50).
marks(raihan, physics, 48).
marks(raihan, ict, 60).
marks(raihan, chemistry, 57).

% attendance(Student, DaysPresent).
attendance(mamun, 28).
attendance(samia, 25).
attendance(rakib, 18).
attendance(anika, 30).
attendance(raihan, 22).

% assignments_completed(Student, Number).
assignments_completed(mamun, 5).
assignments_completed(samia, 4).
assignments_completed(rakib, 2).
assignments_completed(anika, 5).
assignments_completed(raihan, 3).

% Family relationships
family(mamun, raihan).  % mamun-raihan shown together
family(samia, anika).   % samia-anika shown together

% Subject prerequisites
subject_requires(physics, math).

% -------------------------------
% RULES
% -------------------------------

% Pass Rule
pass(Student, Subject) :-
    marks(Student, Subject, Mark),
    Mark >= 40.

% Fail Rule
fail(Student, Subject) :-
    marks(Student, Subject, Mark),
    Mark < 40.

% Grade Rule
grade(Student, Subject, 'A') :-
    marks(Student, Subject, Mark),
    Mark >= 80.

grade(Student, Subject, 'B') :-
    marks(Student, Subject, Mark),
    Mark >= 70, Mark < 80.

grade(Student, Subject, 'C') :-
    marks(Student, Subject, Mark),
    Mark >= 60, Mark < 70.

grade(Student, Subject, 'D') :-
    marks(Student, Subject, Mark),
    Mark >= 40, Mark < 60.

grade(Student, Subject, 'F') :-
    marks(Student, Subject, Mark),
    Mark < 40.

% Total marks of a student across all subjects
total_marks(Student, Total) :-
    findall(Mark, marks(Student, _, Mark), MarksList),
    sum_list(MarksList, Total).

% Average marks
average_marks(Student, Average) :-
    findall(Mark, marks(Student, _, Mark), MarksList),
    sum_list(MarksList, Total),
    length(MarksList, Count),
    Count > 0,
    Average is Total / Count.

% Topper - highest average
topper(Student) :-
    average_marks(Student, Avg),
    \+ (average_marks(_, OtherAvg), OtherAvg > Avg).

% Eligible for scholarship
eligible_for_scholarship(Student) :-
    average_marks(Student, Avg),
    Avg >= 85,
    attendance(Student, Days),
    Days >= 28.

% Weak student - low attendance or low average
weak_student(Student) :-
    average_marks(Student, Avg),
    (Avg < 50; attendance(Student, Days), Days < 20).

% Prerequisite rule - can_take_subject/2
can_take_subject(Student, physics) :-
    marks(Student, math, MathMark),
    MathMark >= 40.  % Must pass math to take physics

can_take_subject(Student, Subject) :-
    subject(Subject),
    Subject \= physics.  % Other subjects have no prerequisites

% Family performance comparison
family_performance_better(Student1, Student2) :-
    student(Student1),
    student(Student2),
    total_marks(Student1, Total1),
    total_marks(Student2, Total2),
    Total1 > Total2.

% Recursive family performance check for multiple students
family_performance_ranking([_]).
family_performance_ranking([First, Second|Rest]) :-
    family_performance_better(First, Second),
    family_performance_ranking([Second|Rest]).