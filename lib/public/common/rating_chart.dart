// Copyright (c) 2017, cjtoribio. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:GPingPong/model/rating.dart';
import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/public/service/user_service.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:math' as math;
import 'package:chartjs/chartjs.dart';
import 'dart:html';

@Component(
  selector: 'rating-chart',
//  styleUrls: const ['app.css'],
  template: """
    <div [ngStyle]="{width: width, height: height}">
      <canvas #chartCanvas></canvas>
    </div>
  """,
  directives: const [materialDirectives],
  providers: const [materialProviders, UserService],
)
class RatingChart implements OnDestroy {

  RatingChart(this.userService);

  Chart chart = null;

  UserService userService;

  @ViewChild("chartCanvas")
  ElementRef canvas;

  @Input("width")
  String width;

  @Input("height")
  String height;

  void open(User user) {
    print(user.ldap);
    userService.getUserRating(user).then((List<Rating> ratings) {
      print(ratings);
      var rnd = new math.Random();
      var counts = ratings.map((r) => r.gamesPlayed).toList();
      var months = <String>["January", "February", "March", "April", "May", "June"];
      print(counts);
      print(ratings.map((r) => r.score).toList());
      var data = new LinearChartData(labels: counts, datasets: <ChartDataSets>[
        new ChartDataSets(
            label: user.name,
            backgroundColor: "rgba(220,220,220,0.2)",
            data: ratings.map((r) =>
               r.score.round()
            ).toList())
//        new ChartDataSets(
//            label: "My Second dataset",
//            backgroundColor: "rgba(151,187,205,0.2)",
//            data: months.map((_) => rnd.nextInt(100)).toList())
      ]);

      var config = new ChartConfiguration(
          type: 'line', data: data, options: new ChartOptions(responsive: true));
      if(chart != null){
        chart.destroy();
        chart = null;
      }
      chart = new Chart(canvas.nativeElement as CanvasElement, config);
    });
  }


  @override
  ngOnDestroy(){
    chart.destroy();
  }
}
