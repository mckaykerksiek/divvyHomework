import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import ChartView from './ChartView.js';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business

  getChartValues() {
    var returnArr = []
    // order the dates from earliest to latest
    let rev = this.business.revenue.sort(function(a, b){
      if (a.date > b.date)
        return 1;
      if (a.date < b.date)
        return -1;
      return 0;});

    var highDate = 0

    // create objects that contain x and y values for the char
    for (let i = 0; i < rev.length; i++) {

      // replace the '-'s in the date string with '/'s. Date() doesn't work otherwise. 
      // explanation found at this link: https://stackoverflow.com/questions/35660278/some-code-only-works-while-chrome-debugger-is-active/35728172
      let dateStr = rev[i].date.replace(/\-/g,'/') 
      let date = new Date(dateStr)
      var month = date.getMonth()

      // months need to be in chronological order for the chart, taking year into account.
      // ex) since the loop is going through sorted dates, if a january comes after december, that january needs to be higher
      // than december. add 12 to the january to make it 13 so the chart is still in the right order.
      if (month > highDate) {
        highDate = month
      }
      if (month < highDate ) {
        month += 12
      }
      let val = {
        x: month,
        y: rev[i].value,
      }
      returnArr.push(val)
    }
    return returnArr
  }
 
  render() {

    return (
      <View style={styles.container}>
        <View style={styles.infoContainer}>
          <Text style={styles.title}> { this.business.name } </Text>
          <Text style={styles.location}> { this.business.location.address} {this.business.location.city}, {this.business.location.country}</Text>
        </View>
        <Text style={styles.subtitle}> Last 6 months' revenue: </Text>
        <ChartView style={styles.chart} values={this.getChartValues()}/> 
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   padding: 8,
   backgroundColor: 'white'
  },
  infoContainer: {
    height: 100,
    paddingVertical: 20
  },
  title: {
    fontSize: 32
  },
  subtitle: {
    fontSize: 20
  },
  location: {
    paddingLeft: 2,
    fontSize: 12,
    color: 'grey'
  },
  listImage: {
    width: 50,
    height: 50,
    margin: 12
  },
  chart: {
    padding: 12,
    height: 300
  }
});
