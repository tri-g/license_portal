import {Col, Modal, Row} from "react-bootstrap";
import {Link} from "react-router-dom";
import React, {useState} from "react";

export default function UserHistory({id, name, email, num, address}) {
  const [show_video_modal, setVideoModal] = useState(false)

  return (
    <>
                                <tbody>
                                    <tr>
                                        <td>
                                            {id}
                                        </td>
                                        <td>
                                           {name}
                                        </td>
                                        <td>
                                          {email}
                                        </td>
                                        <td>
                                            {num}
                                        </td>
                                        <td>
                                            {address}
                                        </td>
                                    </tr>
                                </tbody>
                           
    </>
  )
}
