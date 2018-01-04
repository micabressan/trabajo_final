package de.pkeck.manni.api;

import android.os.Handler;
import android.os.Looper;

import java.lang.annotation.Annotation;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.concurrent.CompletableFuture;

import javax.annotation.ParametersAreNonnullByDefault;

import retrofit2.Call;
import retrofit2.CallAdapter;
import retrofit2.Callback;
import retrofit2.HttpException;
import retrofit2.Response;
import retrofit2.Retrofit;

/**
 * A mix between Java8CallAdapterFactory (from retrofit-adapters library), which allows Retrofit methods that return a
 * {@link CompletableFuture}, and {@link retrofit2.ExecutorCallAdapterFactory}, which executes callbacks (i.e. resolves
 * the future) on Android's main UI thread.
 */
@ParametersAreNonnullByDefault
public class Java8ExecutorCallAdapterFactory extends CallAdapter.Factory {

    private final Handler handler = new Handler(Looper.getMainLooper());

    @Override
    public CallAdapter<?, ?> get(Type returnType, Annotation[] annotations, Retrofit retrofit) {
        if (getRawType(returnType) != CompletableFuture.class) {
            return null;
        }
        if (!(returnType instanceof ParameterizedType)) {
            throw new IllegalStateException("CompletableFuture return type must be parameterized"
                    + " as CompletableFuture<Foo> or CompletableFuture<? extends Foo>");
        }
        Type innerType = getParameterUpperBound(0, (ParameterizedType) returnType);

        if (getRawType(innerType) != Response.class) {
            // Generic type is not Response<T>. Use it for body-only adapter.
            return new BodyCallAdapter<>(handler, innerType);
        }

        // Generic type is Response<T>. Extract T and create the Response version of the adapter.
        if (!(innerType instanceof ParameterizedType)) {
            throw new IllegalStateException("Response must be parameterized"
                    + " as Response<Foo> or Response<? extends Foo>");
        }
        Type responseType = getParameterUpperBound(0, (ParameterizedType) innerType);
        return new ResponseCallAdapter<>(handler, responseType);
    }

    private static final class BodyCallAdapter<R> implements CallAdapter<R, CompletableFuture<R>> {
        private final Handler handler;
        private final Type responseType;

        BodyCallAdapter(Handler handler, Type responseType) {
            this.handler = handler;
            this.responseType = responseType;
        }

        @Override
        public Type responseType() {
            return responseType;
        }

        @Override
        public CompletableFuture<R> adapt(final Call<R> call) {
            final CompletableFuture<R> future = new CompletableFuture<R>() {
                @Override
                public boolean cancel(boolean mayInterruptIfRunning) {
                    if (mayInterruptIfRunning) {
                        call.cancel();
                    }
                    return super.cancel(mayInterruptIfRunning);
                }
            };

            call.enqueue(new Callback<R>() {
                @Override
                public void onResponse(Call<R> call, Response<R> response) {
                    handler.post(() -> {
                        if (response.isSuccessful()) {
                            future.complete(response.body());
                        } else {
                            future.completeExceptionally(new HttpException(response));
                        }
                    });
                }

                @Override
                public void onFailure(Call<R> call, Throwable t) {
                    handler.post(() -> future.completeExceptionally(t));
                }
            });

            return future;
        }
    }

    private static final class ResponseCallAdapter<R>
            implements CallAdapter<R, CompletableFuture<Response<R>>> {
        private final Handler handler;
        private final Type responseType;

        ResponseCallAdapter(Handler handler, Type responseType) {
            this.handler = handler;
            this.responseType = responseType;
        }

        @Override
        public Type responseType() {
            return responseType;
        }

        @Override
        public CompletableFuture<Response<R>> adapt(final Call<R> call) {
            final CompletableFuture<Response<R>> future = new CompletableFuture<Response<R>>() {
                @Override
                public boolean cancel(boolean mayInterruptIfRunning) {
                    if (mayInterruptIfRunning) {
                        call.cancel();
                    }
                    return super.cancel(mayInterruptIfRunning);
                }
            };

            call.enqueue(new Callback<R>() {
                @Override
                public void onResponse(Call<R> call, Response<R> response) {
                    handler.post(() -> future.complete(response));
                }

                @Override
                public void onFailure(Call<R> call, Throwable t) {
                    handler.post(() -> future.completeExceptionally(t));
                }
            });

            return future;
        }
    }
}