import * as React from "react";
import { Card, CardHeader, TextField, Avatar, FontIcon, FloatingActionButton, RaisedButton, AutoComplete, CardText, List, ListItem, MenuItem, IconMenu, IconButton, TouchTapEvent } from "material-ui";
import { ChipPerson } from "../Components/PersonList/ChipPersonRow";
import {grey400, grey700} from "material-ui/styles/colors";
import { api, PeopleSearchResultDTO } from "../Services/Api";
import MoreVertIcon from "material-ui/svg-icons/navigation/more-vert";
import { debounce } from "lodash";
import { ContentClear } from "material-ui/svg-icons";


const primaryStyle = {
    display: "block",
    marginLeft: "60px",
    lineHeight: 1.5,
    paddingTop: "5px"
  };

const secondaryStyle = {
    color: grey700,
    fontSize: "90%",
    display: "block",
    marginLeft: "60px",
    lineHeight: 1.3,
    paddingBottom: "5px"
  };

const singlePositionStyle = {
    display: "block"
};

export interface Person {
    readonly name: string;
    readonly surname: string;
    readonly titleBefore: string;
    readonly titleAfter: string;
    readonly usosId: string;
}

interface PersonListEditPageProps {
    listId: number;
}

interface SearchSourceType {
    text: string;
    dto: PeopleSearchResultDTO;
    value: any;
}

interface PersonListEditPageState {
    searchDataSource: SearchSourceType[];
    listName: string;
    searchText: string;
    persons: Person[];
}

export class PersonListEditPage extends React.Component<{},
    PersonListEditPageState> {
        constructor(props: PersonListEditPageProps) {
            super(props);

            this.state = {
                searchDataSource: [],
                searchText: "",
                listName: "",
                persons: []
            };

            this.handleSearchUpdateInput = debounce(this.handleSearchUpdateInput, 1000);

            this.updateCourseName = this.updateCourseName.bind(this);
        }

    handleSearchUpdateInput = async (value: string) => {
        if (value === "") { return; }
        let response = await api.peopleSearch({ maximumResults: 5, query: value });

        if (response.result) {
            this.setState({ searchDataSource: response.result.map(i =>
                ({
                    text: (i.titleBefore ? i.titleBefore + " " : "") + i.firstName + " " + i.lastName + (i.titleAfter ? " " + i.titleAfter : ""),
                    value: (
                    <MenuItem
                    leftAvatar={<Avatar src={i.photo100Url}/>}
                    children={
                        <div>
                        <span style={primaryStyle}>{(i.titleBefore ? i.titleBefore + " " : "") + i.firstName + " " + i.lastName + (i.titleAfter ? " " + i.titleAfter : "")}</span>
                        <span style={secondaryStyle}>{i.positions.map(x => <span style={singlePositionStyle}>{x}</span> ) }</span>
                      </div>
                    }
                  />
                    ),
                    dto: i
                })
            ) });
        }
    }

    handleSearchNewRequest = async (chosenRequest: string, index: number) => {
        if (index === -1) {
            // TextField input value from chosenRequest
            console.warn("C'mon. Click it. Don't be lazy. It's been implemented yet.");

        }
        else {
            // index in dataSource of the list item selected
            let dto = this.state.searchDataSource[index].dto;
            let person: Person = {
                name: dto.firstName,
                surname: dto.lastName,
                titleBefore: dto.titleBefore,
                titleAfter: dto.titleAfter,
                usosId: dto.id
            };
            this.setState({persons: [person, ...this.state.persons]});
        }
    }

    rightIconMenu = (
        <IconButton tooltip="Usuń z listy" onClick={this.deleteFromList}>
          <FontIcon className="material-icons" color={grey400}>clear</FontIcon>
        </IconButton>
      );

    deleteFromList(event: TouchTapEvent) {
        // react to click
    }

    updateCourseName(event: any, newValue: string) {
        return this.setState({listName: newValue});
      }

    renderListRow(data: Person) {
        return (
            <ListItem
                primaryText={(data.titleBefore ? data.titleBefore + " " : "") + data.name + " " + data.surname + (data.titleAfter !== null ? " " + data.titleAfter : "")}
                rightIconButton={this.rightIconMenu}
                key={data.usosId} />
        );
    }

    render() {
        return (
            <div>
                <Card>
                    <CardHeader
                        title="Edycja listy osób"
                        subtitle="To są prywatne listy osób z systemu USOS dla których możesz ustalać terminy spotkań i generować plany zbiorcze. Wybierz listę aby przejść dalej." />
                </Card>
                <TextField
                    hintText="Nazwa listy"
                    onChange={this.updateCourseName}
                    floatingLabelText="Nazwa listy" />
                <AutoComplete
                    hintText="Możesz wyszukiwać po imieniu, nazwisku lub numerze indeksu z USOS"
                    dataSource={this.state.searchDataSource}
                    onUpdateInput={this.handleSearchUpdateInput}
                    onNewRequest={this.handleSearchNewRequest}
                    floatingLabelText="Nowa osoba"
                    filter={AutoComplete.noFilter}
                    fullWidth={true} />
                <List>
                    {this.state.persons.map(this.renderListRow, this)}
                </List>
                <RaisedButton
                    label="Zapisz"
                    primary={true}
                    style={{
                        float: "right",
                        margin: 12
                    }} />
            </div>
        );
    }
}