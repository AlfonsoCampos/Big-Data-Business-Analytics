import java.io.IOException;
import java.util.*;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

public class PalabrasDistintas {
        public static class Map extends MapReduceBase implements Mapper<LongWritable,Text,Text,IntWritable> {
                private final static IntWritable one = new IntWritable(1);
                private Text palabra = new Text("");

                public void map(LongWritable key, Text value, OutputCollector<Text,IntWritable> output, Reporter reporter) throws IOException {
                        palabra.set(value.toString());
                        output.collect(palabra,one);
                }
        }

        public static class Combiner extends MapReduceBase implements Reducer<Text,IntWritable, Text,IntWritable> {
                private final static IntWritable one = new IntWritable(1);
                private Text total = new Text("Total Lineas Distintas: ");

                public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
                        output.collect(total,one);
                }
        }

        public static class Reduce extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
                public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
                        int sum = 0;
                        while (values.hasNext()) {
                                sum += 1;
                                values.next();
                        }
                        output.collect(key, new IntWritable(sum));
                }
        }

        public static void main(String[] args) throws Exception {
                JobConf conf = new JobConf(PalabrasDistintas.class);
                conf.setJobName("Palabras Distintas");

                conf.setOutputKeyClass(Text.class);
                conf.setOutputValueClass(IntWritable.class);

                conf.setMapperClass(Map.class);
                conf.setCombinerClass(Combiner.class);
                conf.setReducerClass(Reduce.class);

                conf.setNumMapTasks(1);
                conf.setNumReduceTasks(1);

                conf.setInputFormat(TextInputFormat.class);
                conf.setOutputFormat(TextOutputFormat.class);

                FileInputFormat.setInputPaths(conf, new Path(args[0]));
                FileOutputFormat.setOutputPath(conf, new Path(args[1]));

                JobClient.runJob(conf);
        }
}