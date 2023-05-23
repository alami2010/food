/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-insights',
  templateUrl: './insights.component.html',
  styleUrls: ['./insights.component.scss']
})
export class InsightsComponent implements OnInit {
  complaints: any[] = [];
  reasons: any[] = [
    this.util.translate('The product arrived too late'),
    this.util.translate('The product did not match the description'),
    this.util.translate('The purchase was fraudulent'),
    this.util.translate('The product was damaged or defective'),
    this.util.translate('The merchant shipped the wrong item'),
    this.util.translate('Wrong Item Size or Wrong Product Shipped'),
    this.util.translate('Driver arrived too late'),
    this.util.translate('Driver behavior'),
    this.util.translate('Store Vendors behavior'),
    this.util.translate('Issue with Payment Amout'),
    this.util.translate('Others'),
  ];

  issue_With: any[] = [
    '',
    this.util.translate('Order'),
    this.util.translate('Store'),
    this.util.translate('Driver'),
    this.util.translate('Product')
  ];
  todayStates = {
    total: 0,
    totalSold: 0,
    label: ''
  }

  weeekStates = {
    label: '',
    total: 0,
    totalSold: 0
  }

  monthStats = {
    label: '',
    total: 0,
    totalSold: 0
  }

  todayStatesRejected = {
    total: 0,
    totalSold: 0,
  }

  weeekStatesRejected = {
    total: 0,
    totalSold: 0
  }

  monthStatsRejected = {
    total: 0,
    totalSold: 0
  }

  topProducts: any[] = [];
  monthLabel: any = '';

  chartDoughnutData = {
    labels: ['View Chart'],
    datasets: [
      {
        data: [0]
      }
    ]
  };

  monthsChartData: any[] = [];
  weeksChartData: any[] = [];
  todayChartData: any[] = [];
  chartBarDataMonths = {
    labels: ['View Chart'],
    datasets: [
      {
        label: 'View Chart',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };

  chartBarDataWeek = {
    labels: ['View Chart'],
    datasets: [
      {
        label: 'View Chart',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };
  chartBarDataToday = {
    labels: ['View Chart'],
    datasets: [
      {
        label: 'View Chart',
        backgroundColor: '#f87979',
        data: [0]
      }
    ]
  };
  constructor(
    public util: UtilService,
    public api: ApiService,
    public cd: ChangeDetectorRef
  ) {
  }

  ngOnInit(): void {
    this.getStasData();

  }

  getStasData() {
    this.api.post_private('v1/orders/getStoreStatsData', { id: localStorage.getItem('uid') }).then((data: any) => {
      console.log(data);
      if (data && data.status && data.status == 200 && data.data) {
        const week = data.data.week.data;
        const month = data.data.month.data;
        const today = data.data.today.data;
        this.complaints = data.data.complaints;
        this.weeekStates.label = data.data.week.label;
        this.todayStates.label = data.data.today.label;
        this.monthStats.label = data.data.month.label;
        console.log(week);
        let weekDeliveredOrder: any[] = [];
        let weekDeliveredTotal: any = 0;
        let weekRejectedOrder: any[] = [];
        let weekRejectedTotal: any = 0;

        let monthDeliveredOrder: any[] = [];
        let monthDeliveredTotal: any = 0;
        let monthRejectOrder: any[] = [];
        let monthRejectedTotal: any = 0;

        let todayDeliveredOrder: any[] = [];
        let todayDeliveredTotal: any = 0;
        let todayRejectOrder: any[] = [];
        let todayRejectedTotal: any = 0;

        let allOrders: any[] = [];

        today.forEach(async (element: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);

            element.items.forEach((element: any) => {
              allOrders.push(element);
            });
            const status = element.status;

            if (status == 4) {
              element.items.forEach((order: any) => {
                let price = 0;

                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                todayDeliveredTotal = todayDeliveredTotal + price;
                todayDeliveredOrder.push(order);
              });
            }
            if (status == 5 || status == 6) {
              element.items.forEach((order: any) => {
                let price = 0;

                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                todayRejectedTotal = todayRejectedTotal + price;
                todayRejectOrder.push(order);
              });
            }
          }
        });

        const todaysDateChart = [...new Set(today.map((item: any) => moment(item.created_at).format('DD-MMM hh: a')))];
        let todaysDataChart: any[] = [];
        todaysDateChart.forEach(dt => {
          const item = {
            date: dt,
            sells: today.filter((x: any) => moment(x.created_at).format('DD-MMM hh: a') == dt),
            totalSell: 0
          }
          todaysDataChart.push(item)
        });
        todaysDataChart.forEach(data => {
          let orderTotal = 0;
          data.sells.forEach((element: any) => {
            element.items.forEach((order: any) => {
              let price = 0;
              if (order && order.discount == 0) {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }

                } else {
                  price = price + (parseFloat(order.price) * order.quantity);
                }
              } else {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }
                } else {
                  price = price + (parseFloat(order.discount) * order.quantity);
                }
              }
              orderTotal = orderTotal + price;
            });
          });
          data.totalSell = orderTotal;
          console.log('order total ->', orderTotal);
        });
        this.todayChartData = todaysDataChart;
        console.log('todayChartData data chart', todaysDataChart);

        week.forEach(async (element: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);

            element.items.forEach((element: any) => {
              allOrders.push(element);
            });
            const status = element.status;

            if (status == 4) {
              element.items.forEach((order: any) => {
                let price = 0;
                console.log(order);
                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                weekDeliveredTotal = weekDeliveredTotal + price;
                weekDeliveredOrder.push(order);
              });
            }
            if (status == 5 || status == 6) {
              element.items.forEach((order: any) => {
                let price = 0;

                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                weekRejectedTotal = weekRejectedTotal + price;
                weekRejectedOrder.push(order);
              });
            }
          }
        });
        const weeksDateChart = [...new Set(week.map((item: any) => moment(item.created_at).format('DD MMM')))];
        let weeksDataChart: any[] = [];
        weeksDateChart.forEach(dt => {
          const item = {
            date: dt,
            sells: week.filter((x: any) => moment(x.created_at).format('DD MMM') == dt),
            totalSell: 0
          }
          weeksDataChart.push(item)
        });
        weeksDataChart.forEach(data => {
          let orderTotal = 0;
          data.sells.forEach((element: any) => {
            element.items.forEach((order: any) => {
              let price = 0;
              if (order && order.discount == 0) {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }

                } else {
                  price = price + (parseFloat(order.price) * order.quantity);
                }
              } else {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }
                } else {
                  price = price + (parseFloat(order.discount) * order.quantity);
                }
              }
              orderTotal = orderTotal + price;
            });
          });
          data.totalSell = orderTotal;
          console.log('order total ->', orderTotal);
        });

        this.weeksChartData = weeksDataChart;
        console.log('weeks data chart', weeksDataChart);
        month.forEach(async (element: any) => {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(element.items)) {
            element.items = JSON.parse(element.items);

            element.items.forEach((element: any) => {
              allOrders.push(element);
            });
            const status = element.status;

            if (status == 4) {
              element.items.forEach((order: any) => {
                let price = 0;

                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                monthDeliveredTotal = monthDeliveredTotal + price;
                monthDeliveredOrder.push(order);
              });
            }
            if (status == 5 || status == 6) {
              element.items.forEach((order: any) => {
                let price = 0;

                if (order && order.discount == 0) {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }

                  } else {
                    price = price + (parseFloat(order.price) * order.quantity);
                  }
                } else {
                  if (order.size == 1) {
                    if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                      order.savedVariationsList.forEach((variants: any) => {
                        price = price + (parseFloat(variants.price) * variants.quantity);
                      });
                    }
                  } else {
                    price = price + (parseFloat(order.discount) * order.quantity);
                  }
                }
                monthRejectedTotal = monthRejectedTotal + price;
                monthRejectOrder.push(order);
              });
            }
          }
        });
        const monthsDateChart = [...new Set(month.map((item: any) => moment(item.created_at).format('DD MMM')))];
        let monthsDataChart: any[] = [];
        monthsDateChart.forEach(dt => {
          const item = {
            date: dt,
            sells: month.filter((x: any) => moment(x.created_at).format('DD MMM') == dt),
            totalSell: 0
          }
          monthsDataChart.push(item)
        });
        monthsDataChart.forEach(data => {
          let orderTotal = 0;
          data.sells.forEach((element: any) => {
            element.items.forEach((order: any) => {
              let price = 0;
              if (order && order.discount == 0) {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }

                } else {
                  price = price + (parseFloat(order.price) * order.quantity);
                }
              } else {
                if (order.size == 1) {
                  if (order && order.savedVariationsList && order.savedVariationsList.length > 0) {
                    order.savedVariationsList.forEach((variants: any) => {
                      price = price + (parseFloat(variants.price) * variants.quantity);
                    });
                  }
                } else {
                  price = price + (parseFloat(order.discount) * order.quantity);
                }
              }
              orderTotal = orderTotal + price;
            });
          });
          data.totalSell = orderTotal;
          console.log('order total ->', orderTotal);
        });
        this.monthsChartData = monthsDataChart;
        // console.log('months data chart', monthsDataChart);

        this.todayStates.total = todayDeliveredTotal;
        this.todayStates.totalSold = todayDeliveredOrder.length;

        this.todayStatesRejected.total = todayRejectedTotal;
        this.todayStatesRejected.totalSold = todayRejectOrder.length;

        this.weeekStates.total = weekDeliveredTotal;
        this.weeekStates.totalSold = weekDeliveredOrder.length;

        this.weeekStatesRejected.total = weekRejectedTotal;
        this.weeekStatesRejected.totalSold = weekRejectedOrder.length;

        this.monthStats.total = monthDeliveredTotal;
        this.monthStats.totalSold = monthDeliveredOrder.length;

        this.monthStatsRejected.total = monthRejectedTotal;
        this.monthStatsRejected.totalSold = monthRejectOrder.length;

        console.log('today delivered', todayDeliveredOrder, todayDeliveredTotal);
        console.log('today rejected', todayRejectOrder, todayRejectedTotal);

        console.log('week delivered', weekDeliveredOrder, weekDeliveredTotal);
        console.log('week rejected', weekRejectedOrder, weekRejectedTotal);

        console.log('month delivered', monthDeliveredOrder, monthDeliveredTotal);
        console.log('month rejected', monthRejectOrder, monthRejectedTotal);



        console.log('all Order', allOrders);
        const uniqueId = [...new Set(allOrders.map(item => item.id))];
        console.log(uniqueId);
        let topProducts: any[] = [];
        uniqueId.forEach((element: any) => {
          const info = allOrders.filter(x => x.id == element);
          if (info && info.length > 0) {
            if (topProducts.length < 10) {
              const item = {
                id: element,
                items: info[0],
                counts: info.length
              };
              topProducts.push(item);
            }
          }
        });
        this.topProducts = topProducts.sort(({ counts: a }, { counts: b }) => b - a);
        console.log(topProducts);
        console.log(this.topProducts);
        this.openChart();
      }
    }, error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log(error);
      this.util.apiErrorHandler(error);
    });
  }

  async openChart() {
    console.log('parse chart');
    this.topProducts.forEach((element: any) => {
      this.chartDoughnutData.labels.push(element.items.name);
      this.chartDoughnutData.datasets[0].data.push(element.counts);
    });

    this.monthsChartData.forEach((element: any) => {
      this.chartBarDataMonths.labels.push(element.date);
      this.chartBarDataMonths.datasets[0].data.push(element.totalSell);
    });

    this.weeksChartData.forEach((element: any) => {
      this.chartBarDataWeek.labels.push(element.date);
      this.chartBarDataWeek.datasets[0].data.push(element.totalSell);
    });

    this.todayChartData.forEach((element: any) => {
      this.chartBarDataToday.labels.push(element.date);
      this.chartBarDataToday.datasets[0].data.push(element.totalSell);
    });

    this.monthLabel = this.monthStats.label;
    this.cd.detectChanges();
    console.log(this);
  }

  getContent1() {
    return this.util.translate("Items with images lead to more orders compared to items without them. Check your competitor item prices");
  }

  getContent2() {
    return this.util.translate("You have accepted all orders till now in this month");
  }

  getContent3() {
    return this.util.translate("You have some rejected and cancelled orders on your current month's stats, this will impact on your future sells, improve your self");
  }

  getContent4() {
    return this.util.translate("Set campaigns on your own and offer customized discounts to give a further boost to your sales.");
  }

}
