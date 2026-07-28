package mypackage;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/**
 * Matrix Multiplication using Hadoop MapReduce
 *
 * Input format:
 * A,row,column,value
 * B,row,column,value
 *
 * Example:
 * A,0,0,1
 * A,0,1,2
 * B,0,0,5
 * B,1,0,6
 */
public class MatrixMultiply {

    public static class MapClass extends Mapper<LongWritable, Text, Text, Text> {

        @Override
        public void map(LongWritable key, Text value, Context context)
                throws IOException, InterruptedException {

            String[] tokens = value.toString().trim().split(",");
            if (tokens.length != 4) return;

            String matrix = tokens[0];
            String row = tokens[1];
            String col = tokens[2];
            String val = tokens[3];

            Configuration conf = context.getConfiguration();
            int n = Integer.parseInt(conf.get("n", "2"));

            if (matrix.equalsIgnoreCase("A")) {
                for (int k = 0; k < n; k++) {
                    context.write(new Text(row + "," + k),
                            new Text("A," + col + "," + val));
                }
            } else if (matrix.equalsIgnoreCase("B")) {
                for (int k = 0; k < n; k++) {
                    context.write(new Text(k + "," + col),
                            new Text("B," + row + "," + val));
                }
            }
        }
    }

    public static class ReduceClass extends Reducer<Text, Text, Text, DoubleWritable> {

        @Override
        public void reduce(Text key, Iterable<Text> values, Context context)
                throws IOException, InterruptedException {

            Map<String, Double> A = new HashMap<>();
            Map<String, Double> B = new HashMap<>();

            for (Text t : values) {
                String[] parts = t.toString().split(",");
                if (parts[0].equals("A")) {
                    A.put(parts[1], Double.parseDouble(parts[2]));
                } else {
                    B.put(parts[1], Double.parseDouble(parts[2]));
                }
            }

            double sum = 0.0;

            for (String k : A.keySet()) {
                if (B.containsKey(k)) {
                    sum += A.get(k) * B.get(k);
                }
            }

            context.write(key, new DoubleWritable(sum));
        }
    }

    public static void main(String[] args) throws Exception {

        if (args.length != 2) {
            System.err.println("Usage: MatrixMultiply <input> <output>");
            System.exit(-1);
        }

        Configuration conf = new Configuration();

        // Number of columns in Matrix B (for the sample 2x2 matrix)
        conf.set("n", "2");

        Job job = Job.getInstance(conf, "Matrix Multiplication");

        job.setJarByClass(MatrixMultiply.class);

        job.setMapperClass(MapClass.class);
        job.setReducerClass(ReduceClass.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(DoubleWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
