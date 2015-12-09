function  unit_test()
    test_genRandQuad()
    test_gradDescent()
    test_moving_average()
    display('OK. All tests passed.')
end

function test_genRandQuad()
   myfunc = genRandQuad(1,1);
   A = myfunc{3}(1)/2 * 1.0;
   b = myfunc{2}(0) * 1.0; 
   c = myfunc{1}(0) * 1.0;
   
   x = rand(1,1);
   error = abs( myfunc{1}(x) - (A*x*x + b*x + c));
   
   if(error > 1e-5)
     error('error');    
   end
   
   display('OK. Test 1 passed.')
end

function test_gradDescent()
  grad = @(x) 2*x; 
  x = 1.0; step = 1.0;
  error = abs( gradDescent(grad, x, step) + 1);
  if(error > 1e-5)
     error('error');    
  end
  display('OK. Test 2 passed.')
end

function test_moving_average()
input_seq = rand(100,1); 
ma = 0; 
for i=1: length(input_seq)
    ma = moving_average(ma,i-1, input_seq(i));
end

error = ma - mean(input_seq);
if( error > 1e-5)
    error('error');
end 
display('OK. Test 3 passed.')
end

