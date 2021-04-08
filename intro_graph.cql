
// create a Student entity
CREATE (s:Students)

// create a Students entity for hannah
CREATE (s:Student)

// create a Students entity for hannah
CREATE (s:Student {firstName: 'Hannah'})

// create a STUDENTS entity
// note that Students and STUDENTS are different entities
// that is, entities are CASE sensitive
CREATE (s:STUDENTS)

// add more students to the database
// note that each STUDENT is represented by a different variable
// these variables are s1,s2,...,s10
CREATE (s1:STUDENTS {name: 'yong fang'})
CREATE (s2:STUDENTS {name: 'ann'})
CREATE (s3:STUDENTS {name: 'felipe'})
CREATE (s4:STUDENTS {name: 'pwint'})
CREATE (s5:STUDENTS {name: 'yizhou'})
CREATE (s6:STUDENTS {name: 'hannah'})
CREATE (s7:STUDENTS {name: 'lorena'})
CREATE (s8:STUDENTS {name: 'gyanakshi'})
CREATE (s9:STUDENTS {name: 'yeo'})
CREATE (s10:STUDENTS {name: 'mesbaul'})

// add a record for lecturer
CREATE (l:LECTURER {name:'santos'})


// since we are only interested in STUDENTS entity
// delete Students and Student 
//(remember they are different entities due to CASE sensitivity)
MATCH (s:Students)
DETACH DELETE s
RETURN s

MATCH (s:Student)
DETACH DELETE s
RETURN s

// find all students STUDENTS
// stud is a variable for STUDENTS entity
MATCH (stud:STUDENTS)
RETURN stud

// count
MATCH (s:STUDENTS)
RETURN s, count(*)

// count and collect and use an alias for the column
MATCH (s:STUDENTS)
RETURN s, collect(s) AS name

// count distinct
MATCH (s:STUDENTS)
RETURN s, collect(distinct s.name) AS names

// find all distinct students
MATCH (s:STUDENTS)
RETURN DISTINCT s.name, COLLECT(s.name) AS students

MATCH (s:STUDENTS)
RETURN s.name
ORDER BY s.name

// find felipe
MATCH (f:STUDENTS)
WHERE f.name = 'felipe'
RETURN f

// find ann and felipe who are both STUDENTS
// note that each STUDENTS entity
// is represented by a different variable
MATCH (a:STUDENTS),(f:STUDENTS)
WHERE a.name = 'ann' AND f.name = 'felipe'
RETURN a,f

// find ann and felipe who are both STUDENTS
// but use a different variable
MATCH  (a:STUDENTS),(b:STUDENTS)
WHERE a.name = 'ann' AND b.name =  'felipe'
RETURN a,b

// since we know that ann and felipe exists
// we can now create a relationship between ann and felipe
MATCH (a:STUDENTS),(f:STUDENTS)
WHERE a.name = 'ann' AND f.name = 'felipe'
CREATE (a)-[r:KNOWS]->(f)


// of course we can do the same as the previous
// using a different variable
MATCH  (a:STUDENTS),(b:STUDENTS)
WHERE a.name = 'ann' AND b.name =  'felipe'
CREATE (a)-[r:KNOWS]->(b)
RETURN a,b

// lets add another student to the STUDENTS record
CREATE (d:STUDENTS {name:  'daniela'})

// now that daniela exists
// lets suppose that daniela and lorena are friends
// and so we can create a relationship between them
MATCH (u:STUDENTS),(v:STUDENTS)
WHERE u.name = 'lorena' AND v.name = 'daniela'
CREATE (u)-[r:FRIENDS]->(v)
RETURN u,v

// suppose it is known that daniela and loreana
// are not only friends but also share a house
MATCH (u:STUDENTS),(v:STUDENTS)
WHERE u.name = 'lorena' AND v.name = 'daniela'
CREATE (v)-[r:LIVES_WITH]->(u)
RETURN u,v

// lets create a UNITS record for the subjects
// that students are taking
CREATE (u:UNITS {name:'DATA4200'})
RETURN u

// let suppose that all students are studying
// DATA4200 and create a relationship to reflect this
MATCH (u:UNITS),(s:STUDENTS)
CREATE (s)-[r:STUDIES]->(u)
RETURN s,u

// now lets create a relationship
// of the lecturer to DATA4200
MATCH (l:LECTURER),(u:UNITS)
CREATE (l)-[r:TEACHES]->(u)
RETURN l,u

