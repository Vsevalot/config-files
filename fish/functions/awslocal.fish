function awslocal --wraps='aws --endpoint-url http://0.0.0.0:4566' --description 'alias awslocal=aws --endpoint-url http://0.0.0.0:4566'
  aws --endpoint-url http://0.0.0.0:4566 $argv; 
end
