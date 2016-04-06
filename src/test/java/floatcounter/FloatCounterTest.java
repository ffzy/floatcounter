package floatcounter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.Test;

/**
 * Created by zhangy12 on 4/3/2016.
 */
public class FloatCounterTest extends FloatCounter {
    private static final Logger log = LoggerFactory.getLogger(FloatCounterTest.class);

    private static FloatCounter fc = new FloatCounterTest("C:\\work_space\\fileprocessor\\testfile.txt");

    FloatCounterTest(String pathName) {
        super(pathName);
    }

    @Test
    public void testProcessLineHappyPath() {
        fc.processLine("1.1 2.2 3.3 4.46");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineMultiSpaces() {
        fc.processLine("1.1 2.2  3.3   4.46");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineTab() {
        fc.processLine("1.1\t2.2\t\t3.3 \t 4.46");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineSpaceHeadAndTail() {
        fc.processLine("  1.1 2.2 3.3 4.46  ");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
        fc.processLine("\t  1.1 2.2 3.3 4.46 \t");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineDouble() {
        fc.processLine("1234567890.012345678901234 2.2 3.3 4.46");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineAlphabet() {
        fc.processLine("1.01  2.2ab cd 3.3.3 4.46");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }

    @Test
    public void testProcessLineEmpty() {
        fc.processLine("");
        log.info("Count: " + fc.getCount() + "; Sum: " + fc.getSum());
    }
}
