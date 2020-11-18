1)
create user data@'%' IDENTIFIED by "data_analyst"; 

2)
grant select, update, delete on sakila.* to 'data'@'%';

3)-- SQL Error [1142] [42000]: CREATE command denied to user 'data'@'172.17.0.1' for table 'tablita'

4)
update film 
set title = "tituloreloco"
where title = "ACADEMY DINASAUR"

5) 
revoke update on sakila.* from 'data'@'%'; 

6)
-- SQL Error [1142] [42000]: UPDATE command denied to user 'data'@'172.17.0.1' for table 'film'
