DROP Table User;
DROP table Address;
DROP table Board;
DROP table Comment;
DROP table Parking;
DROP table Notification;
DROP table Device;
DROP table Disturb;
DROP table ChatApp;
DROP table ChattingRoom;
DROP table Attachment;
DROP table Report;
DROP table Board_Comment_Report;
DROP table Signature;
DROP table User_Vote_App;
DROP table Vote_App;
DROP table Vote_Choice;



create Table User (
	user_id BIGINT not null,
    user_name varchar(40) not null,
    user_login_id varchar(40) not null,
    user_pw varchar(40) not null,
    user_phone bigint not null,
    user_nickname varchar(40) not null,
    user_join_datd datetime not null,
    login_type varchar(40) not null,
    address_id bigint not null,
    parking_id bigint,
    family_token bigint not null,
    
    primary key (user_id),
    foreign key (address_id) references Address(address_id),
    foreign key (parking_id) references Parking(parking_id)    
    
);
create Table Address (
	address_id bigint not null,
    address_apartment varchar(255) not null,
    address_dong smallint not null,
    address_ho smallint not null,
    
    primary key (address_id)
    
);

create Table Board (
	board_id bigint not null,
    board_name varchar(40) not null,
    user_id bigint not null,
    board_title varchar(255) not null,
    board_content varchar(2000) not null,
    board_regdate datetime not null,
    board_updatedate datetime,
    board_deletedate datetime,
    board_like smallint,
    
    primary key(board_id),
    foreign key (user_id) REFERENCES User(user_id)
   
);

create Table Comment (
	comment_id bigint not null,
    board_id bigint not null,
    comment_content varchar(1000) not null,
    comment_regdate datetime not null,
    comment_updatedate datetime,
    comment_deletedate datetime,
    comment_order smallint not null,
    comment_group smallint not null,
    comment_depth tinyint not null,
    comment_like smallint,
    
    primary key(comment_id),
    foreign key(board_id) references Board(board_id)
);

CREATE TABLE Parking(
	parking_id	BIGINT NOT NULL,
    parking_car_number_first	SMALLINT	NOT NULL,
    parking_car_number_middle	VARCHAR(10)	NOT NULL,
    parking_car_number_last		SMALLINT	NOT NULL,
    
    primary key (parking_id)
);

CREATE TABLE Notification(
	notification_id		BIGINT	NOT NULL,
    device_id			BIGINT	NOT NULL,
    notification_type	VARCHAR(40)	NOT NULL,
    notification_content	VARCHAR(1000)	NOT NULL,
    notification_count		INT		NOT NULL,
    notification_regdate	DATETIME	NOT NULL,
    
    primary key (notification_id),
    foreign key(device_id) references Device(device_id)
);

CREATE TABLE Device(
	device_id		BIGINT	NOT NULL,
    device_token	VARCHAR(255)	NOT NULL,
    user_id			BIGINT		NOT NULL,
    
    primary key		(device_id),
    foreign key(user_id) references User(user_id)
);

CREATE TABLE Disturb(
	disturb_id		BIGINT	NOT NULL,
    disturb_start_time		time	NOT NULL,
    disturb_finish_time		TIME	NOT NULL,
    user_id		bigint	NOT NULL,
    
    primary key		(disturb_id),
    foreign key(user_id) references User(user_id)
);

CREATE TABLE ChatApp(
	chatapp_id		BIGINT	NOT NULL,
    user_id			BIGINT	NOT NULL,
    chattingroom_id	BIGINT	NOT NULL,
    
    primary key		(chatapp_id),
    foreign key(chattingroom_id) references ChattingRoom(chattingroom_id)
);

CREATE TABLE ChattingRoom(
	chattingroom_id		BIGINT	NOT NULL,
    chattingroom_content	VARCHAR(100)	NOT NULL,
    message_id			BIGINT	NOT NULL,
    message_date		datetime	NOT NULL,
    outgoing_id			BIGINT		NOT NULL,
    incoming_id			BIGINT		NOT NULL,
    
    primary key		(chattingroom_id)
);

CREATE	TABLE	Attachment(
	attachment_id	BIGINT	NOT NULL,
    attachment_name		VARCHAR(255) NOT NULL,
    attachment_file		VARCHAR(255)	NOT NULL,
    attachment_size		BIGINT		NOT NULL,
    chattingroom_id		BIGINT		NOT NULL,
    
    primary key		(attachment_id),
    foreign key(chattingroom_id) references ChattingRoom(chattingroom_id)
);

Create Table Report(
	report_id		BIGINT		NOT NULL,
	report_content varchar(255) not null,
	primary key (report_id)
);

CREATE TABLE Board_Comment_Report (
	
    board_comment_report_id BIGINT PRIMARY KEY,
    board_id BIGINT,
    comment_id BIGINT,
    chattingroom_id BIGINT,
    FOREIGN KEY (board_id) REFERENCES Board(board_id),
    FOREIGN KEY (comment_id) REFERENCES Comment(comment_id),
    FOREIGN KEY (chattingroom_id) REFERENCES ChattingRoom(chattingroom_id)
);

CREATE TABLE Signature (
    signature_id BIGINT PRIMARY KEY,
    is_pinned BIGINT,
    signature_regdate DATETIME,
    signature_deadline DATETIME,
    writer_user_id BIGINT,
    joining_user_id BIGINT NOT NULL,
    joining_dong SMALLINT NOT NULL,
    joining_ho SMALLINT NOT NULL
);

CREATE TABLE User_Vote_App (
    user_vote_app_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    vote_app_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (vote_app_id) REFERENCES Vote_App(vote_app_id)
);

CREATE TABLE Vote_App (
    vote_app_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vote_app_headline VARCHAR(1000) NOT NULL,
    vote_app_contents VARCHAR(2000) NOT NULL,
    vote_app_regdate DATETIME NOT NULL,
    vote_app_deadline DATETIME NOT NULL
);

CREATE TABLE Vote_Choice (
    vote_choice_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vote_choice_content VARCHAR(1000) NOT NULL,
    vote_count BIGINT NOT NULL,
    vote_app_id BIGINT,
    FOREIGN KEY (vote_app_id) REFERENCES Vote_App(vote_app_id)
);