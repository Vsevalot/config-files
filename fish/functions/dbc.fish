function dbc --wraps='psql -h localhost -U postgres -p 5432' --description 'alias dbc=psql -h localhost -U postgres -p 5432'
  psql -h localhost -U postgres -p 5432 $argv; 
end
