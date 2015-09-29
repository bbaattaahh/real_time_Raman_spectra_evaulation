function tests = CLS_ertekeles_Test
tests = functiontests(localfunctions);
end

function testCLS_ertekeles_1(testCase)
    x = [10; 30; 50];
    res = CLS_ertekeles(x,x);
    verifyEqual(testCase, round(res), 1.0)
end 

function testCLS_ertekeles_2(testCase)
    x = [10; 30];
    res = CLS_ertekeles(x,x);
    verifyEqual(testCase, round(res), 1.0)
end 
