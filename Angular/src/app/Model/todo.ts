export class Todo{
    name:String;
    description:String;
    isdone:boolean;
    due_Date:any;
    constructor(){
        this.name="";
        this.description="";
        this.isdone=false;
        this.due_Date=new Date();
    }
}