/*Muestra los empleados que ganan más del salario medio de la empresa. Muestra
también dicho salario medio.*/

SELECT e.ename, (SELECT  avg(e.sal) FROM emp e)
FROM emp e
WHERE e.SAL > (SELECT  avg(e.sal) FROM emp e)

/*Muestra los empleados que ganan más del salario medio de su departamento.
Muestra también dicho salario medio.
*/

select ename, sal, deptno, salario_medio
from emp e join (select deptno depart, avg(sal) salario_medio
from emp
group by deptno)
on deptno=depart
where sal>salario_medio


/*Muestra de cada proyecto, el empleado que más horas trabaja.*/

SELECT empno,prono,hours 
FROM EMPPRO p2 
WHERE hours > ALl  (SELECT hours  FROM EMPPRO e2 WHERE  e2.PRONO  = p2.PRONO)

select prono, ename, hours
from emp natural join emppro
where (prono,hours)=SOME(select prono, max(hours)
from emppro
group by prono)

/*El empleado que ha trabajado más horas en cada ciudad. Muestra los nombres del
empleado y de la ciudad.*/

SELECT loc,ename
FROM emppro ep JOIN pro p ON p.PRONO = ep.prono
				JOIN emp e ON e.EMPNO = ep.EMPNO 
WHERE (loc,hours) = ANY (SELECT loc,Max(hours)
 FROM emppro ep1 JOIN pro p1 ON ep1.prono = p1.PRONO  GROUP BY loc)

 
 /*Muestra la media de horas dedicadas a proyectos (sumando las horas de todos los
empleados que trabajan en el proyecto).*/
 
SELECT avg(horas)
 FROM (SELECT sum(hours) horas FROM EMPPRO e GROUP BY PRONO)
 
 /*Muestra los proyectos cuya suma de horas es mayor que la cantidad de horas
media dedicadas a proyectos. Debes mostrar dicha suma.*/
 
 SELECT pname,sum (e.HOURS)
 FROM EMPPRO e JOIN pro p ON e.PRONO  = p.PRONO 
 GROUP BY e.PRONO ,p.PNAME 
 HAVING SUM(e.HOURS)  > ( 
 SELECT avg(horas) 
 FROM (SELECT sum(hours) horas FROM EMPPRO e GROUP BY PRONO))
 ORDER BY  sum(HOURS) 

 
 
SELECT prono,empno
FROM EMPPRO e 
