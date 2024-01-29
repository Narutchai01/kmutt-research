import ImageProfile from "./ImageProfile"
import { AdminData } from "../interface/interface";
import PropTypes from "prop-types";


const TitleProfile = ({ userData }: { userData: AdminData }) => {
    return (
        <div className="grid grid-cols-[1fr_4fr] items-center w-full justify-center">
            <ImageProfile ImageURL={userData.Image} />
            <div className="flex items-center gap-1">
                <h1 className="text-lg">{userData.First_name}</h1>
                <h1 className="text-lg">{userData.Last_name}</h1>
            </div>
        </div>
    );
};

TitleProfile.propTypes = {
    userData: PropTypes.object.isRequired,
};

export default TitleProfile;
