import 'package:get/get.dart';
import 'package:paging_master/data/adapters/task_adapter.dart';
import 'package:paging_master/data/model/task_model.dart';
import 'package:paging_master/utilities/universalfunctions.dart';



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

//fetch list data from pages
  fetchList() async{
    bool gotInternetConnection = await hasInternetConnection(
      context: Get.overlayContext,
      canShowAlert: true,
      onFail: () {
        loading.value = false;
        bottomLoading.value=false;
      },
      onSuccess: () {},
    );

    if (!gotInternetConnection) {
      loading.value = false;
      bottomLoading.value=false;
      return;
    }

    tasks.value = await taskAdapter.loadTasks(page: page.toString());
    dataList.addAll(tasks.value.data);
    tasks.value.data=dataList;

    //hide loaders
    loading.value = false;
    bottomLoading.value=false;


  }

}
