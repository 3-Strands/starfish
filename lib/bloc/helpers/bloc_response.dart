class BlocResponse<T> {
  Status status;

  T? data;

  BlocResponse.loading() : status = Status.LOADING;

  BlocResponse.active(this.data) : status = Status.ACTIVE;

  BlocResponse.done() : status = Status.DONE;

  BlocResponse.error() : status = Status.ERROR;

  @override
  String toString() {
    return "status: $status, data: $data";
  }
}

enum Status { LOADING, ACTIVE, DONE, ERROR }
