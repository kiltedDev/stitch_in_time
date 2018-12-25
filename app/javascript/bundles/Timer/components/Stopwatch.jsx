import PropTypes from 'prop-types';
import React, {Component} from 'react';

class Stopwatch extends Component {
  state = {
    runningTime: 0,
    startTime: this.props.startTime,
    prettyTime: "00:00:00"
  };
  componentDidMount() {
    this.setState(state => {
      this.timer = setInterval(() => {
        let ms = Date.now() - this.props.startTime
        let hours = Math.floor((ms/1000/60/60) << 0).toString();
        let minutes = Math.floor((ms/1000/60) % 60).toString();
        let seconds = Math.floor((ms/1000) % 60).toString();

        if (hours.length <2) {
          hours = "0" + hours;
        };

        if (minutes.length <2) {
          minutes = "0" + minutes;
        };

        if (seconds.length <2) {
          seconds = "0" + seconds;
        };

        let newPrettyTime = hours + ":" + minutes + ":" + seconds;
        this.setState({
          prettyTime: newPrettyTime
        });
      }, 1000);
    });
  };
  render() {
    const { runningTime, prettyTime } = this.state;
    return (
      <div className="col-12 clock-screen">
        <span>{prettyTime}</span>
      </div>
    );
  }
}

export default Stopwatch;
