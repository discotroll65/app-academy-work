import React from 'react';
import ReactDOM from 'react-dom';


class App extends React.Component {

  constructor(props){
    super(props);
  }

  render(){
    <div>Oh hey I did it</div>
  }

}

document.addEventListener('DOMContentLoaded', () =>{
  const root = document.getElementById('root');

  ReactDOM.render(<App/>, root);
});