function tests = old_school_baseline_Test
tests = functiontests(localfunctions);
end


function test_old_school_baseline_Test_1(testCase)
    x = [10; 30; 50];
    bl_ponts = [1; 1; 1];
    res = old_school_baseline(x, bl_ponts);
    verifyEqual(testCase, round(res), x)
end 


function test_old_school_baseline_Test_2(testCase)
    x = [10; 30; 50; 30; 10];
    bl_ponts = [1; 1; 0; 1; 1];
    res = old_school_baseline(x, bl_ponts);
    verifyEqual(testCase, round(res), [10; 30; 30; 30; 10])
end 
