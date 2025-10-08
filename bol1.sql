/*Para cada departamento mostrar su nombre y cuántos empleados tiene, si no
tiene ninguno, indicarlo con un 0.*/

SELECT d.dname,COUNT(e.EMPNO) 
FROM DEPT d LEFT JOIN emp e ON d.DEPTNO  = e.DEPTNO  
GROUP BY d.DNAME ,d.DEPTNO 

/*Para cada empleado mostrar las horas que trabajó en proyectos, si no trabajó en
ninguno, indicarlo con un 0.*/

SELECT e.ename , COALESCE ( sum(HOURs),0)
FROM EMP e LEFT JOIN EMPPRO p ON e.EMPNO = p.EMPNO 
GROUP BY e.EMPNO ,e.ENAME 

/*Para cada empleado muestra su nombre, el nombre de su jefe, y el departamento
para el que trabaja su jefe. Si el empleado no tiene jefe, debe aparecer con nulos
en los datos del jefe.*/

SELECT e.ename AS emplado ,j.ename AS jefe,d.DNAME AS departamento
FROM EMP e Left JOIN emp j ON e.mgr = j.EMPNO LEFT  JOIN dept d ON j.DEPTNO = d.DEPTNO 


/*Para cada empleado muestra en cuántas ciudades distintas ha trabajado. Si no ha
trabajado en ninguna, debe mostrar un cero. Muestra el nombre del empleado.*/

SELECT e.ename,COUNT(DISTINCT  p.loc)
FROM EMP e LEFT JOIN EMPPRO ep ON e.EMPNO = ep.EMPNO LEFT JOIN PRO p ON ep.PRONO =p.PRONO 
GROUP BY e.ENAME 

/*En los proyectos controlados por los departamentos 30 y 40, muestra cuántos
empleados distintos han trabajado en ellos. Si no han trabajado empleados, debe
mostrar un cero. Muestra el nombre del departamento.*/

Select d.dname, count (distinct ep.empno)
from dept d left join pro p on d.deptno=p.deptno
left join emppro ep on ep.prono=p.prono
group by d.deptno, d.dname
having d.deptno=30 or d.deptno=40


/*Muestra cuántos empleados subordinados tiene cada jefe, que fueran contratados
el mismo año. Si no tiene ninguno debe mostrar un cero.*/


SELECT DISTINCT  j.ename,count( e.empno)
FROM EMP j LEFT JOIN emp e ON j.EMPNO = e.MGR and to_char(e.hiredate,'YYYY')=
to_char(j.hiredate,'YYYY')
where j.empno in (select mgr from emp)
group by j.empno, j.ename

/*Muestra los empleados que han trabajado en proyectos ubicados en la misma
localidad donde está su departamento.*/

SELECT DISTINCT  e.ename
FROM EMP e  JOIN EMPPRO e2 ON e.EMPNO = e2.EMPNO 
			JOIN PRO p ON e2.PRONO = p.PRONO JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE p.LOC = d.LOC 

/*Para cada empleado mostrar cuántas veces trabajó en proyectos ubicados en la
misma ciudad donde está su departamento.*/

SELECT  e.ename,count (e.ENAME) 
FROM EMP e  JOIN EMPPRO e2 ON e.EMPNO = e2.EMPNO 
			JOIN PRO p ON e2.PRONO = p.PRONO JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE p.LOC = d.LOC 
GROUP BY e.ENAME 


/*Idem anterior, pero mostrando un cero cuando nunca ocurrió*/

SELECT  e.ename,count (d.loc) 
FROM EMP e Left JOIN EMPPRO e2 ON e.EMPNO = e2.EMPNO 
			left JOIN PRO p ON e2.PRONO = p.PRONO  left JOIN DEPT d ON e.DEPTNO = d.DEPTNO AND p.LOC = d.LOC 
GROUP BY e.EMPNO , e.ENAME 
ORDER BY COUNT(d.LOC) desc 

