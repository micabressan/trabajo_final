//--------------------------------------------------------------
package lab11;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CachedThreadPoolTest {
public static void main(String[] args) {
	ExecutorService executor=Executors.newCachedThreadPool();
	executor.execute(new ClassRunnable());
	executor.execute(new ClassRunnable());
	executor.execute(new ClassRunnable());
	executor.execute(new ClassRunnable());
	executor.execute(new ClassRunnable());
	executor.shutdown();
}
}
//testCallbable -----------------------------------------------------------
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

class MyCallableTaskDouble implements Callable<Double> {
	private Double a, b;

	MyCallableTaskDouble(Double a, Double b) {
		this.a = a;
		this.b = b;
	}

	@Override
	public Double call() throws Exception {
		return a / b;
	}
}

public class TestCallable {

	private static <T extends Callable<U>, U> void test(List<T> tasks) {
		List<Future<U>> results = new ArrayList<Future<U>>();
		ExecutorService executor = Executors.newCachedThreadPool();
		for (T task : tasks)
			results.add(executor.submit(task));
		for (Future<U> result : results)
			try {
				System.out.println(result.get());
			} catch (InterruptedException e) {
				e.getCause().printStackTrace();
			} catch (ExecutionException e) {
				e.getCause().printStackTrace();
			}
		executor.shutdown();
	}

	public static void main(String[] args) {
		ArrayList<MyCallableTaskDouble> tasksDouble = new ArrayList<MyCallableTaskDouble>();
		tasksDouble.add(new MyCallableTaskDouble(1d, 0d));
		tasksDouble.add(new MyCallableTaskDouble(-1d, 0d));
		tasksDouble.add(new MyCallableTaskDouble(0d, 0d));
		test(tasksDouble);
	}
}
//testPriorityExecutor--------------------------
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.TimeUnit;

enum PriorityLevel {
	NO_PRIORITY(0), LOW_PRIORITY(1), MEDIUM_PRIORITY(2), HIGH_PRIORITY(3);

	private int value;

	PriorityLevel(int value) {
		this.value = value;
	}

	int getValue() {
		return value;
	}
}

class PriorityTask implements Runnable, Comparable<PriorityTask> {
	private PriorityLevel priorityLevel;
	private int taskNumber;
	private Runnable runnable;

	PriorityTask(int taskNumber, PriorityLevel priority, Runnable runnable) {
		this.taskNumber = taskNumber;
		this.priorityLevel = priority;
		this.runnable = runnable;
	}

	@Override
	public void run() {
		System.out.printf("%-30s %d%n", "START " + this, System.currentTimeMillis());
		runnable.run();
	}

	@Override
	public int compareTo(PriorityTask t) {
		return t.priorityLevel.getValue() - this.priorityLevel.getValue();
	}

	@Override
	public String toString() {
		return taskNumber + ": " + priorityLevel;
	}
}

class PriorityExecutor implements Executor {

	PriorityExecutor(final ExecutorService executor, final boolean sleep) {
		new Thread() {
			@Override
			public void run() {
				try {
					if (sleep)
						TimeUnit.SECONDS.sleep(1);
					while (true) {
						Runnable r = tasks.poll(10, TimeUnit.SECONDS);
						if (r != null)
							executor.execute(r);
						else
							break;
					}
				} catch (InterruptedException e) {
					throw new RuntimeException(e);
				} finally {
					executor.shutdown();
				}
			}
		}.start();
	}

	final PriorityBlockingQueue<Runnable> tasks = new PriorityBlockingQueue<Runnable>();

	@Override
	public void execute(Runnable r) {
		tasks.add(r);
	}

}

public class TestPriorityExecutor {
	public static void main(String args[]) {
		Runnable r = new Runnable() {
			@Override
			public void run() {
				try {
					TimeUnit.SECONDS.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		};

		PriorityExecutor executor = new PriorityExecutor(Executors.newSingleThreadExecutor(), false);
		executor.execute(new PriorityTask(1, PriorityLevel.NO_PRIORITY, r));
		executor.execute(new PriorityTask(2, PriorityLevel.LOW_PRIORITY, r));
		executor.execute(new PriorityTask(3, PriorityLevel.MEDIUM_PRIORITY, r));
		executor.execute(new PriorityTask(4, PriorityLevel.HIGH_PRIORITY, r));
	}
}

//test priority builder---------------------------------------------------------

import java.io.File;
import java.io.IOException;

public class TestProcessBuilder {
	public static void main(String[] args) throws IOException, InterruptedException {
		ProcessBuilder processBuilder = new ProcessBuilder("C:\\WINDOWS\\system32\\notepad.exe");
		processBuilder.directory(new File("C:\\"));
		Process process = processBuilder.start();
		process.waitFor();
	}
}

// test runable-----------------------------------------------
class MyRunnable implements Runnable {
	public void run() {
		// ...
	}
}

public class TestRunnable {

	public static void main(String[] args) {
		Thread t = new Thread(new MyRunnable());
		t.start();
	}
}

// test runtime--------------------------------------
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class TestRuntime {
	public static void main(String[] args) throws IOException, InterruptedException {
		Runtime runtime = Runtime.getRuntime();

		Process process = runtime.exec("ipconfig /all");
		BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
		String s = null;
		while ((s = input.readLine()) != null)
			if (s.length() > 0)
				System.out.println(s);
		input.close();
		process.waitFor();

		Process process2 = runtime.exec("notepad");
		process2.waitFor();
	}
}
//test thread---------------------------

class MyThread extends Thread {
	@Override
	public void run() {
		// ...
	}
}

public class TestThread {

	public static void main(String[] args) {
		Thread t = new MyThread();
		t.start();
	}
}