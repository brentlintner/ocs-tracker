import React from "react"
import $ from "jquery"
import PropTypes from "prop-types"
import { MuiThemeProvider, createMuiTheme, withStyles } from "@material-ui/core/styles"
import TextField from "@material-ui/core/TextField"
import Button from "@material-ui/core/Button"
import AppBar from "@material-ui/core/AppBar"
import IconButton from "@material-ui/core/IconButton"
import Toolbar from "@material-ui/core/Toolbar"
import MenuIcon from "@material-ui/icons/Menu"
import Typography from "@material-ui/core/Typography"
import Drawer from "@material-ui/core/Drawer"
import List from "@material-ui/core/List"
import Divider from "@material-ui/core/Divider"
import ListItem from "@material-ui/core/ListItem"
import ListItemIcon from "@material-ui/core/ListItemIcon"
import ListItemText from "@material-ui/core/ListItemText"
import InStockIcon from "@material-ui/icons/CheckBox"
import OutOfStockIcon from "@material-ui/icons/Block"
import LowStockIcon from "@material-ui/icons/LowPriority"
import AllStockIcon from "@material-ui/icons/SelectAll"
import SativaIcon from "@material-ui/icons/Brightness7"
import IndicaIcon from "@material-ui/icons/Brightness2"
import HybridIcon from "@material-ui/icons/Brightness6"
import RecentlyStockedIcon from "@material-ui/icons/Sync"
import NewIcon from "@material-ui/icons/FiberNew"
import SoldOutIcon from "@material-ui/icons/Report"
import FavoriteIcon from "@material-ui/icons/Favorite"
import EmailAlertsIcon from "@material-ui/icons/AddAlert"
import HelpIcon from "@material-ui/icons/ContactSupport"
import CodeIcon from "@material-ui/icons/Code"
import blue from "@material-ui/core/colors/blue";

import SearchBar from "./SearchBar"

$(document).on("turbolinks:load", () => {
  $(".app--body--loader").hide()
  $(".app--body--content").show()
})

$(document).on("turbolinks:visit", () => {
  $(".app--body--content").hide()
  $(".app--body--loader").show()
})

const theme = createMuiTheme({
  typography: {
    useNextVariants: true,
  },
  palette: {
    primary: blue,
    secondary: {
      main: "#e91e63",
    },
  }
})

const styles = {
  list: {
    width: 290
  },
  toolbar: {
    paddingLeft: ".25rem",
    paddingRight: 0
  },
  title: {
    [theme.breakpoints.down(600)]: {
      textAlign: "center",
      textOverflow: "ellipsis",
      overflow: "hidden",
      whiteSpace: "nowrap",
      margin: 0,
      padding: 0
    },
  }
}

class App extends React.Component {
  state = {
    top: false,
    left: false,
    bottom: false,
    right: false,
  }

  toggleDrawer = (side, open) => () => {
    this.setState({
      [side]: open,
    })
  }

  render() {
    const { classes, title } = this.props

    const sideList = (
      <div className={"app--menu " + classes.list}>
        <List>
          <a href="/in-stock" >
            <ListItem button key="In Stock">
              <ListItemIcon>
                <InStockIcon />
              </ListItemIcon>
              <ListItemText primary="In Stock" />
            </ListItem>
          </a>
          <a href="/recently-stocked">
            <ListItem button key="Recently Stocked">
              <ListItemIcon>
                <RecentlyStockedIcon />
              </ListItemIcon>
              <ListItemText primary="Recently Stocked" />
            </ListItem>
          </a>
          <a href="/low-stock">
            <ListItem button key="Low Stock">
              <ListItemIcon>
                <LowStockIcon />
              </ListItemIcon>
              <ListItemText primary="Low Stock" />
            </ListItem>
          </a>
          <a href="/out-of-stock">
            <ListItem button key="Out Of Stock">
              <ListItemIcon>
                <OutOfStockIcon />
              </ListItemIcon>
              <ListItemText primary="Out Of Stock" />
            </ListItem>
          </a>
          <a href="/recently-sold-out">
            <ListItem button key="Recently Sold Out">
              <ListItemIcon>
                <SoldOutIcon />
              </ListItemIcon>
              <ListItemText primary="Recently Sold Out" />
            </ListItem>
          </a>
          <a href="/new-products">
            <ListItem button key="New Products">
              <ListItemIcon>
                <NewIcon />
              </ListItemIcon>
              <ListItemText primary="New Products" />
            </ListItem>
          </a>
          <a href="/sativa">
            <ListItem button key="Sativa">
              <ListItemIcon>
                <SativaIcon />
              </ListItemIcon>
              <ListItemText primary="Sativa" />
            </ListItem>
          </a>
          <a href="/indica">
            <ListItem button key="Indica">
              <ListItemIcon>
                <IndicaIcon />
              </ListItemIcon>
              <ListItemText primary="Indica" />
            </ListItem>
          </a>
          <a href="/hybrid">
            <ListItem button key="Hybrid">
              <ListItemIcon>
                <HybridIcon />
              </ListItemIcon>
              <ListItemText primary="Hybrid" />
            </ListItem>
          </a>
          <a href="/all-stock">
            <ListItem button key="All Stock">
              <ListItemIcon>
                <AllStockIcon />
              </ListItemIcon>
              <ListItemText primary="All Stock" />
            </ListItem>
          </a>
          <Divider/>
          <a href="/alerts/subscribe">
            <ListItem button key="Email Alerts">
              <ListItemIcon>
                <EmailAlertsIcon />
              </ListItemIcon>
              <ListItemText primary="Email Alerts" />
            </ListItem>
          </a>
          <a href="https://github.com/brentlintner/ocs-tracker/blob/master/README.md">
            <ListItem button key="Docs">
              <ListItemIcon>
                <CodeIcon />
              </ListItemIcon>
              <ListItemText primary="Docs" />
            </ListItem>
          </a>
          <a href="https://github.com/brentlintner/ocs-tracker/issues">
            <ListItem button key="Issues">
              <ListItemIcon>
                <HelpIcon />
              </ListItemIcon>
              <ListItemText primary="Issues" />
            </ListItem>
          </a>
        </List>
      </div>
    )

    var suggestions = this.props.suggestions || []

    return (
      <MuiThemeProvider theme={theme}>
        <AppBar position="fixed" color="primary">
          <Toolbar className={classes.toolbar}>
            <IconButton onClick={this.toggleDrawer("left", true)} color="inherit" aria-label="Menu">
              <MenuIcon />
            </IconButton>
            <Typography variant="h6" component="h1" color="inherit" className={"app--title " + classes.title}>
              {title}
            </Typography>
            <SearchBar suggestions={suggestions}></SearchBar>
          </Toolbar>
        </AppBar>
        <Drawer open={this.state.left} onClose={this.toggleDrawer("left", false)}>
          <div
            tabIndex={0}
            role="button"
            onClick={this.toggleDrawer("left", false)}
            onKeyDown={this.toggleDrawer("left", false)}
          >
            {sideList}
          </div>
        </Drawer>
      </MuiThemeProvider>
    )
  }
}

App.propTypes = {
  classes: PropTypes.object.isRequired,
  suggestions: PropTypes.array
}

export default withStyles(styles)(App)
