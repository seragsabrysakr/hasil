
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/app.dart';
import 'package:hassel/features/intro/presentation/widgets/slide_text_item.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';

import 'package:injectable/injectable.dart';
part 'intro_state.dart';


@injectable
class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(IntroInitial());
  static IntroCubit get(BuildContext context) =>
      context.read<IntroCubit>();
  int activePage = 0;
  List<String> photos = [
    AppAssets.intro1,
    AppAssets.intro2,
    AppAssets.intro3,
    AppAssets.intro4,
  ];
  List<Widget> sliderItems = [
    SliderTextItem(

      h1:App.tr.intro1Header1 ,
      h2: App.tr.intro1Header2,
      h3: App.tr.intro1Header3,
      h4: App.tr.intro1Header4,
    ),
    SliderTextItem(
      h1:App.tr.intro2Header1 ,
      h2: App.tr.intro2Header2,
      h3: '',
      h4: App.tr.intro2Header4,
    ),
    SliderTextItem(
      h1:App.tr.intro3Header1 ,
      h2: App.tr.intro3Header2,
      h3: '',
      h4: App.tr.intro3Header4,
    ), SliderTextItem(
      h1:App.tr.intro4Header1 ,
      h2: App.tr.intro4Header2,
      h3:'',
      h4: App.tr.intro4Header4,
    ),
  ];
  bool getFirstIndex(){
    bool firstIndex = activePage == 0;
    return firstIndex;
  }


}
