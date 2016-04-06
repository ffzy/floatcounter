package floatcounter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.math.BigDecimal;

/**
 * The main class of Float Counter, a tool to calculate the total count of
 * numbers and the sum of all numbers from a file.
 *
 * Created by zhangy12 on 4/3/2016.
 */
public class FloatCounter {

    private static final Logger log = LoggerFactory.getLogger(FloatCounter.class);

    private File file;
    private int count = 0;
    private BigDecimal sum;

    FloatCounter(String pathName) {
        file = new File(pathName);
        sum = new BigDecimal(0.0);
    }

    public int getCount () {
        return count;
    }

    public BigDecimal getSum() {
        return sum;
    }

    protected void processLine(String line) {
        String[] words = line.trim().split("\\s+");

        for (String word : words) {
            try {
                BigDecimal decimal = new BigDecimal(word);

                sum = sum.add(decimal);
                count++;
            } catch (NumberFormatException e) {
                log.warn("{} when converting from word to float - {}. Skip it.",
                        e.getClass().getSimpleName(), word);
            }
        }
    }

    public void process() throws IOException {
        log.info(file.getPath());
        if(!file.exists() || file.isDirectory()) {
            throw new FileNotFoundException();
        }

        FileInputStream fis = new FileInputStream(file);

        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(fis));

            String line;

            try {
                while ((line = reader.readLine()) != null) {
                    log.info(line);
                    processLine(line);
                    log.info("Current sum: {}", sum);
                }
            } finally {
                if (reader != null) reader.close();
            }
        } finally {
            if (fis != null ) fis.close();
        }

        String result = "Count: " + count + "; Sum: " + sum;
        log.info(result);
        System.out.println(result);
    }

    public static void main(String args[]) {
        String fileName = System.getProperty("fileName");
        if (fileName == null) {
            log.info("File name expected.");
            return;
        }

        FloatCounter fp = new FloatCounter(fileName);

        try {
            fp.process();
        } catch (IOException e) {
            log.error("{} - {}", e.getClass().getSimpleName(), fileName);
        }
    }
}
