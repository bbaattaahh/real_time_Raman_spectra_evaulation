function tests = NomalizationToSum1_Test
tests = functiontests(localfunctions);
end

function testNomalizationToSum1_1(testCase)
    x = [50; 50];
    res = NomalizationToSum1(x);
    verifyEqual(testCase, res, [0.5; 0.5])
end 


function testNomalizationToSum1_2(testCase)
    x = [0; 0; 0; 0];
    res = NomalizationToSum1(x);
    verifyEqual(testCase, res, [0; 0; 0; 0])
end 



function testNomalizationToSum1_3(testCase)
    x = [50; 50; -50];
    res = NomalizationToSum1(x);
    verifyEqual(testCase, res, [0.5; 0.5; 0])
end 
