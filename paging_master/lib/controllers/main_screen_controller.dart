import 'package:get/get.dart';
import 'package:paging_master/data/adapters/task_adapter.dart';
import 'package:paging_master/data/model/task_model.dart';



//this class contains all the variables and ui logic related to main screen
class MainScreenController extends GetxController {
  Rx<TaskModel> tasks = Rx<TaskModel>().obs();
  List<Data> dataList = <Data>[];
  TaskAdapter taskAdapter = TaskAdapter();

  //Bool value to show loader in center for first page data
  RxBool loading = true.obs;

  //Bool value to show loader at bottom for pagination
  RxBool bottomLoading = false.obs;
  int page=1;


  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onReady() {
    fetchList();
  }


  fetchList() async{
    //fetch list data from pages
    tasks.value = await taskAdapter.loadTasks(page: page.toString());
    dataList.addAll(tasks.value.data);
    tasks.value.data=dataList;

    //hide loaders
    loading.value = false;
    bottomLoading.value=false;


  }

}
