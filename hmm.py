1. Check if a student passed a subject
?- pass(mamun, math).
true.

2. Get grade for a student in a subject
?- grade(anika, physics, Grade).
Grade = 'A'.

3. Find total marks of a student
?- total_marks(samia, Total).
Total = 275.

4. Find average marks
?- average_marks(raihan, Avg).
Avg = 54.0.

5. Find the topper
?- topper(Student).
Student = anika.

6. Check scholarship eligibility
?- eligible_for_scholarship(mamun).
false.

7. Identify weak students
?- weak_student(rakib).
true.

8. Check if a student can take physics (prerequisite: pass in math)
?- can_take_subject(rakib, physics).
false.
?- can_take_subject(samia, physics).
true.

9. Compare family members' performance
?- family_performance_better(mamun, raihan).
true.
?- family_performance_better(samia, anika).
false.

10. Rank family performance recursively
?- family_performance_ranking([mamun, raihan]).
true.
?- family_performance_ranking([anika, samia]).
false.
